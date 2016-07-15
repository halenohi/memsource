class RenameMembershipsTable < ActiveRecord::Migration[5.0]
  def self.up
    rename_table :membershipes, :memberships
  end

  def self.down
    rename_table :memberships, :membershipes
  end
end
