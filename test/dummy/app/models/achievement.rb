class Achievement < ActiveRecord::Base
  has_many :achievings

  validates_presence_of :name, :category
  validates_uniqueness_of :name

  def achieve(achiever)
    achievings.create!(:achiever => achiever, :achievement => self)
  end
end

