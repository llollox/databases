module ConnectToDbPasses
  extend ActiveSupport::Concern

  included do
    databases = YAML::load(IO.read('config/databases/passes.yml'))
    establish_connection(databases[Rails.env])
  end

end
