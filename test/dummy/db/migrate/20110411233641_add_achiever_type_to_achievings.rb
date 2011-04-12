class AddAchieverTypeToAchievings < ActiveRecord::Migration
  def self.up
    add_column :achievings, :achiever_type, :string
  end

  def self.down
    remove_column :achievings, :achiever_type
  end
end
