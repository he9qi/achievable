class AchievableGenerator < Rails::Generators::NamedBase
  
  source_root File.expand_path("../templates", __FILE__)
  
  class_option :migration, :type => :boolean, :default => true
  
  def manifest 
    migration_template 'migration.rb', 'db/migrate', :migration_file_name => "achievable_migration"
  end
  
  def copy_achievable_models
    template "achievement.rb", "app/models/achievement.rb"
    template "achieving.rb", "app/models/achieving.rb"
  end
  
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

end
