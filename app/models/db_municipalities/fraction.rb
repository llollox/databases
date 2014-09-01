class Fraction < ActiveRecord::Base
  include ConnectToDbMunicipalities
  include Searchable

  belongs_to :municipality
  belongs_to :region
  belongs_to :localitiable, polymorphic: true

  geocoded_by :address

  def province
    self.municipality.province
  end

  def address
    address = self.name
    address += ", " + self.municipality.name
    address += ", " + self.municipality.province.name
    address += ", " + self.municipality.province.abbreviation
    address += ", " + self.municipality.caps.first.number.to_s if !self.municipality.caps.blank?
    address += ", " + self.region.name
    address += ", Italy"
    return address
  end
  
end