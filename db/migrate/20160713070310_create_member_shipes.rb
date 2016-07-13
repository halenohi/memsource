class CreateMemberShipes < ActiveRecord::Migration[5.0]
  def change
    create_table :member_shipes do |t|
      t.int :user_id
      t.int :circle_id
      t.int :role

      t.timestamps
    end
  end
end
