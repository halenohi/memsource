class CreateMemberShipes < ActiveRecord::Migration[5.0]
  def change
    create_table :member_shipes do |t|
      t.integer :user_id
      t.integer :circle_id
      t.integer :role

      t.timestamps
    end
  end
end
