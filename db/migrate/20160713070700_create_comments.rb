class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :circle_id, null: false
      t.text :content

      t.index [:user_id, :circle_id]
      t.timestamps
    end
  end
end
