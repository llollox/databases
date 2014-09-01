namespace :passes do
 
  desc "Configure the variables that rails need in order to look up for the db
    configuration in a different folder"
  task :set_custom_db_config_paths do
    # This is the minimum required to tell rails to use a different location
    # for all the files related to the database.
    ENV['SCHEMA'] = 'db/db_passes/schema.rb'
    Rails.application.config.paths['db'] = ['db/db_passes']
    Rails.application.config.paths['db/migrate'] = ['db/db_passes/migrate']
    Rails.application.config.paths['db/seeds'] = ['db/db_passes/seeds.rb']
    Rails.application.config.paths['config/database'] = ['config/databases/passes.yml']
  end
 
  namespace :db do
    task :drop => :set_custom_db_config_paths do
      Rake::Task["db:drop"].invoke
    end
 
    task :create => :set_custom_db_config_paths do
      Rake::Task["db:create"].invoke
    end
 
    task :migrate => :set_custom_db_config_paths do
      Rake::Task["db:migrate"].invoke
    end
 
    task :rollback => :set_custom_db_config_paths do
      Rake::Task["db:rollback"].invoke
    end

    task :restore => :set_custom_db_config_paths do
      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      exec "pg_restore --host localhost --username postgres -C --no-owner --no-acl --dbname passes_development #{Rails.root}/db/db_passes/dump.dump"
    end

    task :dump => :set_custom_db_config_paths do
      exec "pg_dump --host localhost --username postgres -C --no-owner --no-acl --format=c passes_development > #{Rails.root}/db/db_passes/dump.dump"
    end      

    task :seed => :set_custom_db_config_paths do
      Rake::Task["db:seed"].invoke
    end

    task :seed => :set_custom_db_config_paths do
      Rake::Task["db:seed"].invoke
    end
 
    task :version => :set_custom_db_config_paths do
      Rake::Task["db:version"].invoke
    end
  end

end