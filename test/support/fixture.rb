class TestUser
  include Mongoid::Document
  include Mongoid::Timestamps
  include Achievable::DSL
  include Achievable::Achiever
  
  store_in :users
end

class TestAchievement
  include Mongoid::Document
  include Mongoid::Timestamps
  
  validates_presence_of :name, :category
  validates_uniqueness_of :name
  
  def achieve(achiever)
    achiever.achievements << self
  end
  
  store_in :achievements
  
end
