class Cap < ActiveRecord::Base
  include ConnectToDbMunicipalities
  belongs_to :municipality
end