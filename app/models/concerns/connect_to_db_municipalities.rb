module ConnectToDbMunicipalities
  extend ActiveSupport::Concern

  included do
    databases = YAML::load(IO.read('config/databases/municipalities.yml'))
    establish_connection(databases[Rails.env])
  end

end
