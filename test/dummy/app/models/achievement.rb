class Achievement
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :image_url
  field :description
  field :category
  
  has_and_belongs_to_many :achievers,    :polymorphic => true
  
  validates_presence_of :name, :category
  validates_uniqueness_of :name
  
  def achieve(achiever)
    achiever.achievements << self
  end
  
end
