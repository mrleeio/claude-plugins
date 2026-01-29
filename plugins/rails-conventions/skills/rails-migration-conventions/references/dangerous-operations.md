# Dangerous Migration Operations

Operations that require special handling to avoid downtime or data loss.

## Removing Columns

**Problem:** Rails may still try to read the column during deployment.

**Solution:** Two-step process.

### Step 1: Ignore the Column

```ruby
# app/models/user.rb
class User < ApplicationRecord
  self.ignored_columns = [:legacy_field]
end
```

Deploy this first. Rails will stop reading the column.

### Step 2: Remove the Column

```ruby
class RemoveLegacyFieldFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :legacy_field
  end
end
```

Deploy after Step 1 is live.

## Renaming Columns

**Never use `rename_column` directly.**

**Solution:** Add, migrate, remove.

```ruby
# Migration 1: Add new column
def change
  add_column :users, :full_name, :string
end

# Application code: Write to both, read from new
def name=(value)
  self.full_name = value
  super  # Write to old column too
end

def name
  full_name || super  # Read from new, fall back to old
end

# Migration 2: Backfill
def up
  User.in_batches do |batch|
    batch.where(full_name: nil).update_all("full_name = name")
  end
end

# Migration 3: Remove old column (after deployment)
def change
  remove_column :users, :name
end
```

## Large Table Indexes

**Problem:** `add_index` locks the table during creation.

**Solution:** Add concurrently.

```ruby
class AddIndexToUsersEmail < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def change
    add_index :users, :email, algorithm: :concurrently
  end
end
```

**Note:** `disable_ddl_transaction!` is required for concurrent operations.

## Removing Indexes

Also use concurrent removal for large tables:

```ruby
class RemoveIndexFromUsersEmail < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def change
    remove_index :users, :email, algorithm: :concurrently
  end
end
```

## Changing Column Types

**Problem:** Type changes can lose data or cause errors.

**Solution:** Use a new column.

```ruby
# Add new column with correct type
add_column :products, :price_decimal, :decimal, precision: 10, scale: 2

# Migrate data (in batches for large tables)
Product.in_batches do |batch|
  batch.update_all("price_decimal = price")
end

# Update application to use new column
# Remove old column after deployment
remove_column :products, :price
```

## Operations Reference

| Operation | Risk | Solution |
|-----------|------|----------|
| Remove column | App errors | Use `ignored_columns` first |
| Rename column | Data loss | Add new, migrate, remove old |
| Add index (large table) | Table lock | Use `algorithm: :concurrently` |
| Change column type | Data loss | Use new column + migrate |
| Add NOT NULL | Migration fails | Add default or backfill first |
| Drop table | Data loss | Backup first, remove references |

## Safety Gems

Consider using:
- [strong_migrations](https://github.com/ankane/strong_migrations) - Catches dangerous migrations
- [safe-pg-migrations](https://github.com/doctolib/safe-pg-migrations) - Auto-safe operations for PostgreSQL
