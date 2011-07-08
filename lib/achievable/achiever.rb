module Achievable
  module Achiever
    extend ActiveSupport::Concern
    include Achievable::AchieveManager

    included do
      has_and_belongs_to_many :achievements
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
      achievement = Achievement.where(:name => name).first
      unless achievement && achieved?(achievement)
        achievement.achieve(self) if ( block_given? ? block.call(self) : true )
      end
    end
    
    def achieved?(achievement)
      if achievement.is_a? String
        achievement = Achievement.where(:name => achievement).first
      end
      achievements.include?(achievement)
    end
    
  end # Achiever
end # Achievable