# Template: State Sub-Resource Controller
# Copy and customize for your resource
# Example: app/controllers/cards/closures_controller.rb

class Cards::ClosuresController < ApplicationController
  before_action :set_card

  def create
    @card.close
    respond_to do |format|
      format.html { redirect_to @card, notice: "Card closed" }
      format.turbo_stream { render_card_update }
    end
  end

  def destroy
    @card.reopen
    respond_to do |format|
      format.html { redirect_to @card, notice: "Card reopened" }
      format.turbo_stream { render_card_update }
    end
  end

  private
    def set_card
      @card = Current.account.cards.find(params[:card_id])
    end

    def render_card_update
      render turbo_stream: turbo_stream.replace(@card, partial: "cards/card", locals: { card: @card })
    end
end
