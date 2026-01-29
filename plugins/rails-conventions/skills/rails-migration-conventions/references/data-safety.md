# Data Safety in Migrations

Handle existing data when modifying database schema.

## The Problem

```ruby
# WRONG - fails if table has rows
add_column :users, :role, :string, null: false
```

This migration fails because existing rows have `NULL` for the new column.

## The Solution

```ruby
# RIGHT - handle existing data
add_column :users, :role, :string, default: 'member'
change_column_null :users, :role, false
```

Or with explicit backfill:

```ruby
def change
  add_column :users, :role, :string

  reversible do |dir|
    dir.up do
      User.update_all(role: 'member')
    end
  end

  change_column_null :users, :role, false
end
```

## Batch Updates for Large Tables

```ruby
def up
  add_column :users, :role, :string

  # Batch to avoid locking
  User.in_batches(of: 1000) do |batch|
    batch.update_all(role: 'member')
  end

  change_column_null :users, :role, false
end
```

## Common Patterns

### Add NOT NULL Column

```ruby
# Step 1: Add nullable column with default
add_column :posts, :status, :string, default: 'draft'

# Step 2: Make non-null
change_column_null :posts, :status, false
```

### Add Required Foreign Key

```ruby
def change
  add_reference :comments, :post, null: true, foreign_key: true

  reversible do |dir|
    dir.up do
      # Assign orphaned comments or delete them
      Comment.where(post_id: nil).destroy_all
    end
  end

  change_column_null :comments, :post_id, false
end
```

### Change Column Type

```ruby
def up
  # Add new column
  add_column :products, :price_cents, :integer

  # Migrate data
  Product.in_batches do |batch|
    batch.each do |product|
      product.update_column(:price_cents, (product.price * 100).to_i)
    end
  end

  # Remove old column
  remove_column :products, :price
end
```

## Testing Migrations

```ruby
# Always test rollback
def test_migration_is_reversible
  migrate_up
  assert User.column_names.include?('role')

  migrate_down
  refute User.column_names.include?('role')
end
```

## Checklist

- [ ] Migration works on empty table
- [ ] Migration works on table with rows
- [ ] Migration is reversible
- [ ] Large tables use batch updates
- [ ] NOT NULL columns have defaults or backfill
