class AddDefaultValueToCirclesMembersCount < ActiveRecord::Migration[5.0]
  def self.up
  	change_column :circles, :members_count, :integer, default: 0
  end

  def self.down
  end
end
