class AchievableMigration < ActiveRecord::Migration
  
  def self.up
    create_table :achievements do |t|
      t.string   :name
      t.string   :image_url
      t.string   :description
      t.integer  :achievings_count, :default => 0
      t.string   :category
      t.timestamps
    end

    create_table :achievings do |t|
      t.integer  :achiever_id
      t.integer  :achievement_id
      t.boolean  :notify,   :default => false
      t.string   :achiever_type
      t.timestamps
    end
    
    add_index :achievements, :name
  end
  
  def self.down
    drop_table :achievings
    drop_table :achievements
  end
  
end
