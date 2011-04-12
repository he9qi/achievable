class CreateAchievings < ActiveRecord::Migration
  def self.up
    create_table :achievings do |t|
      t.integer :achiever_id
      t.integer :achievement_id
      t.boolean :notify, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :achievings
  end
end
