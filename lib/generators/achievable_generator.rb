class AchievableGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Migration  
  
  source_root File.expand_path("../templates", __FILE__)
  
  def set_up_achiever  
    inject_into_class "app/models/#{file_name}.rb", class_name, <<-CONTENT
  include Achievable::Achiever
  CONTENT
  end
  
  def add_application_config
    inject_into_class "config/application.rb", "Application", <<-CONTENT
    # Set achievable resque
    config.achievable.resque_enable = false

CONTENT
  end
  
  def copy_achievable_models
    template "achievement.rb", "app/models/achievement.rb"
  end

end
