module ConnectToDbMoto
  extend ActiveSupport::Concern

  included do
    establish_connection "#{Rails.env}_db_moto".to_sym
  end

end
