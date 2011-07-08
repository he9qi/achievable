class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  include Achievable::Achiever
  include Achievable::DSL
  
  field :name
  field :image_url
  
  has_many :posts
end
