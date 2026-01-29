# Template: Notification Migration
# Copy this file to db/migrate/YYYYMMDDHHMMSS_create_notifications.rb

class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :creator, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.references :source, polymorphic: true, null: false, type: :uuid
      t.datetime :read_at
      t.datetime :bundled_at
      t.timestamps
    end

    add_index :notifications, [:user_id, :read_at]
    add_index :notifications, [:user_id, :created_at]
  end
end
