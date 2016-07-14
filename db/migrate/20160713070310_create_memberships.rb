class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :member_shipes do |t|
      t.integer :user_id, null: false
      t.integer :circle_id, null: false
      t.integer :role

      t.index [:user_id, :circle_id]
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
