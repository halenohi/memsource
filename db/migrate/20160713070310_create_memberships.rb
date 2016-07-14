class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :membershipes do |t|
      t.integer :user_id, null: false
      t.integer :circle_id, null: false

      t.index [:user_id, :circle_id]
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
