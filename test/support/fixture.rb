class TestUser < ActiveRecord::Base
  self.table_name = "users"
  include Achievable::DSL
  include Achievable::Achiever
end

class TestAchievement < ActiveRecord::Base
  self.table_name = "achievements"
  has_many :achievings, :class_name => "TestAchieving"
  
  validates_presence_of :name, :category
  validates_uniqueness_of :name
  
  def achieve(achiever)
    achievings.create!(:achiever => achiever, :achievement => self)
  end
  
end

class TestAchieving < ActiveRecord::Base
  self.table_name = "achievings"
  belongs_to :achiever,    :polymorphic => true
  belongs_to :achievement, :class_name => "TestAchievement", :foreign_key => "achievement_id", :counter_cache => true
end
