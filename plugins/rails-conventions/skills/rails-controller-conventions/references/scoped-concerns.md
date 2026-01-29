# Controller Concerns for DRY Resource Loading

Extract common `before_action` patterns and resource loading into reusable controller concerns. This keeps controllers focused on their specific actions while sharing common setup logic.

## Basic Scoped Concern

```ruby
# app/controllers/concerns/card_scoped.rb
module CardScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_card
  end

  private
    def set_card
      @card = Current.account.cards.find(params[:card_id])
    end
end
```

Usage:

```ruby
# app/controllers/cards/comments_controller.rb
class Cards::CommentsController < ApplicationController
  include CardScoped

  def create
    @comment = @card.comments.create!(comment_params)
  end
end
```

## Nested Resource Scoping

For deeply nested resources, build a chain of concerns:

```ruby
# app/controllers/concerns/board_scoped.rb
module BoardScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_board
  end

  private
    def set_board
      @board = Current.account.boards.find(params[:board_id])
    end
end

# app/controllers/concerns/column_scoped.rb
module ColumnScoped
  extend ActiveSupport::Concern
  include BoardScoped

  included do
    before_action :set_column
  end

  private
    def set_column
      @column = @board.columns.find(params[:column_id])
    end
end
```

Usage:

```ruby
# app/controllers/columns/cards_controller.rb
class Columns::CardsController < ApplicationController
  include ColumnScoped

  def create
    @card = @column.cards.create!(card_params)
  end
end
```

## Authorization Helpers

Add permission checks to your scoped concerns:

```ruby
# app/controllers/concerns/board_scoped.rb
module BoardScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_board
  end

  private
    def set_board
      @board = Current.account.boards.find(params[:board_id])
    end

    def ensure_board_access
      unless @board.accessible_by?(Current.user)
        redirect_to boards_path, alert: "You don't have access to this board"
      end
    end

    def ensure_permission_to_admin_board
      unless @board.administrable_by?(Current.user)
        redirect_to @board, alert: "You don't have permission to do that"
      end
    end
end
```

Usage with specific authorization:

```ruby
# app/controllers/boards/settings_controller.rb
class Boards::SettingsController < ApplicationController
  include BoardScoped
  before_action :ensure_permission_to_admin_board

  def edit
  end

  def update
    @board.update!(board_params)
    redirect_to @board
  end
end
```

## Turbo Stream Helpers

Add common rendering helpers to concerns:

```ruby
# app/controllers/concerns/card_scoped.rb
module CardScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_card
  end

  private
    def set_card
      @card = Current.account.cards.find(params[:card_id])
    end

    def render_card_replacement
      render turbo_stream: turbo_stream.replace(@card, partial: "cards/card", locals: { card: @card })
    end

    def render_card_removal
      render turbo_stream: turbo_stream.remove(@card)
    end

    def broadcast_card_update
      @card.broadcast_replace_to(@card.board, partial: "cards/card", locals: { card: @card })
    end
end
```

## Flexible Parameter Keys

Support different parameter naming conventions:

```ruby
# app/controllers/concerns/card_scoped.rb
module CardScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_card
  end

  private
    def set_card
      @card = Current.account.cards.find(card_id_param)
    end

    def card_id_param
      params[:card_id] || params[:id]
    end
end
```

## Full Example: Comments Controller

```ruby
# app/controllers/concerns/card_scoped.rb
module CardScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_card
  end

  private
    def set_card
      @card = Current.account.cards.find(params[:card_id] || params[:id])
    end

    def ensure_card_access
      unless @card.board.accessible_by?(Current.user)
        head :forbidden
      end
    end
end

# app/controllers/cards/comments_controller.rb
class Cards::CommentsController < ApplicationController
  include CardScoped
  before_action :ensure_card_access

  def index
    @comments = @card.comments.includes(:creator)
  end

  def create
    @comment = @card.comments.create!(comment_params)

    respond_to do |format|
      format.html { redirect_to @card }
      format.turbo_stream
    end
  end

  def destroy
    @comment = @card.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @card }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
```

## Best Practices

1. **Single responsibility**: Each concern handles one resource or one aspect
2. **Chain concerns**: Build nested scoping by including parent concerns
3. **Keep it simple**: Don't over-abstract; extract only when you see repetition
4. **Name clearly**: `CardScoped` sets `@card`, `BoardScoped` sets `@board`
5. **Authorization separate**: Permission checks are separate `before_action` calls
6. **Include helpers**: Add rendering helpers for Turbo responses in the same concern
