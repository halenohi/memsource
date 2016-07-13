class CreateCircles < ActiveRecord::Migration[5.0]
  def change
    create_table :circles do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.int :members_count

      #index生成
      add_index :name, :description

      t.timestamps
    end
  end
end
