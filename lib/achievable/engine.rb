module Achievable
  class Engine < ::Rails::Engine
    config.achievable = ActiveSupport::OrderedOptions.new
    
    initializer "achievable.active_record" do
      ActiveSupport.on_load(:active_record) do
        include Achievable::DSL
      end
    end
    
    initializer "achievable.resque_enable" do |app|
      if app.config.achievable.resque_enable
        Achievable.set_resque_enable(app.config.achievable.resque_enable )
      end
    end
    
  end # Engine
end # Achievable