# Role Hierarchy

Implement role-based authorization with helper methods.

## ApplicationPolicy Helpers

```ruby
# app/policies/application_policy.rb
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  # Role check helpers
  def mentor?
    user.role == "mentor"
  end

  def content_creator?
    user.role == "content_creator"
  end

  def company_admin?
    user.role == "company_admin"
  end

  # Hierarchy helpers
  def mentor_or_above?
    mentor? || content_creator_or_above?
  end

  def content_creator_or_above?
    content_creator? || company_admin?
  end

  # Default permissions
  def index?
    true
  end

  def show?
    true
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
```

## Using Hierarchy Helpers

```ruby
# app/policies/article_policy.rb
class ArticlePolicy < ApplicationPolicy
  def create?
    content_creator_or_above?
  end

  def update?
    content_creator_or_above?
  end

  def destroy?
    company_admin?
  end

  def publish?
    content_creator_or_above?
  end
end
```

## Role Hierarchy Pattern

```
company_admin
    ↓
content_creator
    ↓
  mentor
    ↓
  member (default)
```

Each level includes all permissions of levels below it.

## Complex Hierarchies

For more complex role structures:

```ruby
class ApplicationPolicy
  ROLE_HIERARCHY = {
    "super_admin" => 100,
    "company_admin" => 80,
    "content_creator" => 60,
    "mentor" => 40,
    "member" => 20,
    "guest" => 0
  }.freeze

  def role_level
    ROLE_HIERARCHY.fetch(user.role, 0)
  end

  def at_least?(role)
    role_level >= ROLE_HIERARCHY.fetch(role, 0)
  end

  def mentor_or_above?
    at_least?("mentor")
  end

  def content_creator_or_above?
    at_least?("content_creator")
  end
end
```

## Ownership Checks

Combine role checks with ownership:

```ruby
class ArticlePolicy < ApplicationPolicy
  def update?
    owner? || content_creator_or_above?
  end

  def destroy?
    owner? || company_admin?
  end

  private
    def owner?
      record.author == user
    end
end
```

## Avoid Inline Role Checks

```ruby
# Avoid
def update?
  user.role == "content_creator" || user.role == "company_admin"
end

# Prefer
def update?
  content_creator_or_above?
end
```

Benefits:
- Single place to update hierarchy
- Consistent naming
- Easier to test
- Self-documenting
