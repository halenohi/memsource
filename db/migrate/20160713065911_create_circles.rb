class CreateCircles < ActiveRecord::Migration[5.0]
  def change
    create_table :circles do |t|
      t.string :name, null: false
      t.text :description
      t.integer :members_count

      #index生成
      t.index [:name]

      t.timestamps
    end
  end
end
