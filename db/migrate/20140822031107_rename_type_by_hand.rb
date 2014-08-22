class RenameTypeByHand < ActiveRecord::Migration
  def self.up
    rename_column :questions, :type, :qtype
  end

  def self.down
    rename_column :questions, :qtype, :type
  end
end
