class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.int :user_id
      t.int :circle
      t.text :content

      t.timestamps
    end
  end
end
