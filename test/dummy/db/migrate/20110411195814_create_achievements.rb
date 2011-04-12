class CreateAchievements < ActiveRecord::Migration
  def self.up
    create_table :achievements do |t|
      t.string :name
      t.string :image_url
      t.string :description
      t.integer :achievings_count, :default => 0
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :achievements
  end
end
