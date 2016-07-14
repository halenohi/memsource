class CreateCircles < ActiveRecord::Migration[5.0]
  def change
    create_table :circles do |t|
      t.string :name
      t.string :description
      t.int :members_count

      t.timestamps
    end
  end
end
