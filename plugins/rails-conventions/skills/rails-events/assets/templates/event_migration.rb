# Template: Event Migration
# Copy to db/migrate/YYYYMMDDHHMMSS_create_events.rb

class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events, id: :uuid do |t|
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :creator, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.references :eventable, polymorphic: true, null: false, type: :uuid
      t.string :action, null: false
      t.json :particulars, default: {}
      t.timestamps
    end

    add_index :events, [:eventable_type, :eventable_id, :created_at]
    add_index :events, [:account_id, :created_at]
  end
end
