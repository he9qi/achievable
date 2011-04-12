# coding: utf-8
module Achievable
  module AchieveManager
    extend ActiveSupport::Concern
    
    @queue = :achievable
    
    def achieveit!(name)
      raise NotImplementedError
    end
    
    def achieveit(name, &block)
      block_source = block_given? ? block.to_source : nil
      Resque.enqueue(AchieveManager, {"name" => name, "id" => self.id, "class" => self.class.to_s, "condition" => block_source})
    end  
      
    def self.perform(opts={})
      inst = opts["class"].constantize.find(opts["id"])
      condition = eval(opts["condition"]) if opts["condition"] 
      if condition
        inst.achieveit!(opts["name"], &condition) 
      else
        inst.achieveit!(opts["name"])
      end
    end
    
  end # AchieveManager
end # Jobs