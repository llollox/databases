module ConnectToDbPasses
  extend ActiveSupport::Concern

  included do
    establish_connection "#{Rails.env}_db_passes".to_sym
  end

end
