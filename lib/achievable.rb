require "mongoid"

# We are required to choose a database name
Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("streamit_#{Rails.env}")
end

module Achievable
  autoload :DSL,            'achievable/dsl'
  autoload :Achiever,       'achievable/achiever'
  autoload :AchieveManager, 'achievable/achieve_manager'
  
  # Set which enable resque.
  #
  #   Achievable.set_resque_enable
  #
  def self.set_resque_enable(true_or_false)
    singleton_class.send :define_method, :resque_enable, lambda { true_or_false }
  end

  def self.resque_enable; false; end
  
end

require 'achievable/engine'

