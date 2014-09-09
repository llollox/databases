class Municipality < ActiveRecord::Base
  include ConnectToDbMunicipalities
  include Searchable
  
  belongs_to :province
  belongs_to :region
  has_many :caps
  has_many :fractions

  has_one :symbol, :class_name => "DbComuniPicture", as: :picturable, dependent: :destroy
  has_many :pictures, :class_name => "DbComuniPanoramioPicture", as: :picturable, dependent: :destroy

  before_save :set_region_id

  def set_region_id
    self.region_id = self.province.region.id
  end

  def address
    address = self.name
    address += ", " + self.province.name
    address += " (" + self.province.abbreviation + ")"
    address += ", " + self.caps.first.number.to_s if !self.caps.blank?
    address += ", " + self.region.name
    address += ", Italy"
    return address
  end

end