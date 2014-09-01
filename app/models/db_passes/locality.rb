class Locality < ActiveRecord::Base
  include ConnectToDbPasses
  belongs_to :pass
  belongs_to :localitiable, polymorphic: true
  
end