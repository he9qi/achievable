module Achievable
  module Achiever
    extend ActiveSupport::Concern
    include Achievable::AchieveManager

    included do
      has_many :achievements, :through => :achievings
      has_many :achievings, :dependent => :destroy, :as => :achiever
    end
         
    def achieve(name, options = {})
      condition = options[:condition] ? options[:condition] : ( lambda { |u| true } )
      if Achievable.resque_enable
        achieveit(name, &condition)
      else
        achieveit!(name, &condition)
      end
    end
    
    def achieveit!(name, &block)
      achievement = Achievement.find_by_name!(name)
      unless achieved?(achievement)
        achievement.achieve(self) if ( block_given? ? block.call(self) : true )
      end
    end
    
    def achieved?(achievement)
      if achievement.is_a? String
        achievement = Achievement.find_by_name!(achievement)
      end
      achievements.include?(achievement)
    end
    
  end # Achiever
end # Achievable