class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Achievable::DSL
  
  field :name
  field :description
  
  belongs_to :user
end
