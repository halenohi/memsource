class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :circle, null: false
      t.text :content

      t.index [:user_id, :cirlce]
      t.timestamps
    end
  end
end
