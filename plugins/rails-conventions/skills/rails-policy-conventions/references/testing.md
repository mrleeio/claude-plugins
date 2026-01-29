# Testing Policies

Authorization tests belong in policy specs, not request specs.

## Policy Specs

Fast, focused unit tests for authorization logic:

```ruby
# spec/policies/article_policy_spec.rb
require "rails_helper"

RSpec.describe ArticlePolicy do
  subject { described_class.new(user, article) }

  let(:article) { create(:article) }

  context "as a member" do
    let(:user) { create(:user, role: "member") }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context "as a content_creator" do
    let(:user) { create(:user, role: "content_creator") }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context "as a company_admin" do
    let(:user) { create(:user, role: "company_admin") }

    it { is_expected.to permit_all_actions }
  end
end
```

## Using Pundit Matchers

Add `pundit-matchers` gem for cleaner assertions:

```ruby
# Gemfile
gem "pundit-matchers", "~> 3.0"

# spec/rails_helper.rb
require "pundit/matchers"
```

Available matchers:
- `permit_action(:action_name)`
- `forbid_action(:action_name)`
- `permit_actions([:show, :index])`
- `forbid_actions([:create, :destroy])`
- `permit_all_actions`
- `forbid_all_actions`

## Testing Ownership

```ruby
context "as the article owner" do
  let(:user) { article.author }

  it { is_expected.to permit_action(:update) }
  it { is_expected.to permit_action(:destroy) }
end

context "as a different user" do
  let(:user) { create(:user) }

  it { is_expected.to forbid_action(:update) }
  it { is_expected.to forbid_action(:destroy) }
end
```

## Request Specs: Happy Path Only

Request specs test the full stack with authorized users:

```ruby
# spec/requests/articles_spec.rb
RSpec.describe "Articles" do
  describe "POST /articles" do
    # Use an authorized user (content_creator)
    let(:user) { create(:user, role: "content_creator") }

    before { sign_in(user) }

    it "creates an article" do
      post articles_path, params: { article: { title: "New" } }
      expect(response).to redirect_to(article_path(Article.last))
    end
  end
end
```

**Do NOT test authorization in request specs:**

```ruby
# Avoid this in request specs
it "denies access to members" do
  sign_in(create(:user, role: "member"))
  post articles_path
  expect(response).to have_http_status(:forbidden)
end
```

This belongs in policy specs.

## Why Separate Concerns?

| Test Type | Purpose | Speed |
|-----------|---------|-------|
| Policy specs | Test authorization rules | Fast |
| Request specs | Test full request flow | Slower |

Policy specs are:
- Faster (no HTTP stack)
- Focused (one concern)
- Easier to maintain
- Complete coverage of all roles
