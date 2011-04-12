class Achieving < ActiveRecord::Base
  belongs_to :achiever,    :polymorphic => true
  belongs_to :achievement, :class_name => "Achievement", :foreign_key => "achievement_id", :counter_cache => true
end
