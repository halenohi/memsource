class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :password, null: false
      t.string :email, null: false

      # index生成
      add_index :name, :password, :email

      t.timestamps
    end
  end
end
