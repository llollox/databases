module ConnectToDbMoto
  extend ActiveSupport::Concern

  included do
    databases = YAML::load(IO.read('config/databases/moto.yml'))
    establish_connection(databases[Rails.env])
  end

end
