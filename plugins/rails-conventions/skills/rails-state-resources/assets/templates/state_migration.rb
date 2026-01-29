# Template: State Join Table Migration
# Copy to db/migrate/YYYYMMDDHHMMSS_create_closures.rb
# Adjust table name, foreign key, and columns as needed

class CreateClosures < ActiveRecord::Migration[7.1]
  def change
    create_table :closures, id: :uuid do |t|
      t.references :card, null: false, foreign_key: true, type: :uuid, index: { unique: true }
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
