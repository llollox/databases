namespace :db do 
  DUMPS_DIR = "#{Rails.root}/db/dumps"

  ["moto", "municipalities", "passes"].each do |db_name|  
    namespace "#{db_name}".to_sym do

      desc "Configure the variables that rails need in order to look up for the db
      configuration in a different folder"
      task "set_#{db_name}_db_config_paths".to_sym do
        # This is the minimum required to tell rails to use a different location
        # for all the files related to the database.
        Rails.application.config.paths['db'] = ["db/#{db_name}"]
        Rails.application.config.paths['db/migrate'] = ["db/#{db_name}/migrate"]
        Rails.application.config.paths['db/seeds'] = ["db/#{db_name}/seeds.rb"]
        Rails.application.config.paths['config/database'] = ["config/databases/#{db_name}.yml"]
      end

      task :drop => "set_#{db_name}_db_config_paths".to_sym do
        Rake::Task["db:drop"].invoke
      end

      task :create => "set_#{db_name}_db_config_paths".to_sym do
        Rake::Task["db:create"].invoke
      end

      task :migrate => "set_#{db_name}_db_config_paths".to_sym do
        Rake::Task["db:migrate"].invoke
      end

      task :g_migration => "set_#{db_name}_db_config_paths".to_sym do
        if !ENV['name'].nil?
          # Generate the new migration into the standard directory
          sh "rails g migration #{ENV['name']}"
          # Move the generated migration into the correct directory
          sh "mv db/migrate/*_#{ENV['name']}.rb db/#{db_name}/migrate/"
        else
          puts "Usage rake db:#{db_name}:g_migration name=<migration_name>"
        end
      end

      task :rollback => "set_#{db_name}_db_config_paths".to_sym do
        Rake::Task["db:rollback"].invoke
      end

      task :restore => "set_#{db_name}_db_config_paths".to_sym do
        dumps = Dir["#{DUMPS_DIR}/#{db_name}/*.dump"]
        if dumps.empty?
          puts "There is no available dumps!"
        else
          Rake::Task["db:drop"].invoke
          Rake::Task["db:create"].invoke
          sh "pg_restore --host localhost --username postgres --no-owner --no-acl --dbname #{db_name}_#{Rails.env} #{dumps.last}"
        end
      end

      # task :dump, [:db_name] => "set_#{db_name}_db_config_paths".to_sym do |task, args|
      task :dump => "set_#{db_name}_db_config_paths".to_sym do
        timestamp = Time.now.strftime("%Y-%m-%d_%H:%M:%S")
        sh "mkdir -p #{DUMPS_DIR}/#{db_name}"
        sh "pg_dump --host localhost --username postgres --create --no-owner --no-acl --format=c #{db_name} > DUMPS_DIR/#{db_name}/#{timestamp}.dump"
      end      

      task :seed => "set_#{db_name}_db_config_paths".to_sym do
        Rake::Task["db:seed"].invoke
      end

      task :seed => "set_#{db_name}_db_config_paths".to_sym do
        Rake::Task["db:seed"].invoke
      end

      task :version => "set_#{db_name}_db_config_paths".to_sym do
        Rake::Task["db:version"].invoke
      end
    end
  end
end