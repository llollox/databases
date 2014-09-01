class Pass < ActiveRecord::Base
  include ConnectToDbPasses
  include Searchable
  include Geolocable
  
  has_many :localities

  def address
    address = self.name 
    if !self.localities.empty?
      loc = self.localities.first
      address = address + ", " + loc.municipality.province.name + ", " + loc.municipality.province.region.name if loc.class.name == "Fraction"
      address = address + ", " + loc.province.name + ", " + loc.province.region.name if loc.class.name == "Municipality"
    end
    return address + ", Italy"
  end

  def localitiables
    result = []
    Locality.where(:pass_id => self.id).each do |locality|
      result = result << locality.localitiable
    end
    return result
  end

end