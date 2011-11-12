module Achievable
  module Achiever
    extend ActiveSupport::Concern
    include Achievable::AchieveManager
         
     included do
       field :achievements, :type => Array, :default => []
     end
         
    def achieve(name, options = {})
      return unless Achievement.has_achievement?(name)
      condition = options[:condition] ? options[:condition] : ( lambda { |u| true } )
      if Achievable.resque_enable
        achieveit(name, &condition)
      else
        achieveit!(name, &condition)
      end
    end
    
    def achieveit!(name, &block)
      if !achieved?(name) && ( block_given? ? block.call(self) : true )
        update_attribute :achievements, (achievements << name)
      end
    end
    
    def achieved?(achievement)
      achievements.include?(achievement)
    end
    
  end # Achiever
end # Achievable