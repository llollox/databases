module ConnectToDbMunicipalities
  extend ActiveSupport::Concern

  included do
    establish_connection "#{Rails.env}_db_municipalities".to_sym
  end

end
