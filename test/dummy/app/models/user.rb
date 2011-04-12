class User < ActiveRecord::Base
  include Achievable::Achiever
  has_many :posts
end
