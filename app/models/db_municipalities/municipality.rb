class Municipality < ActiveRecord::Base
  include ConnectToDbMunicipalities
  include Searchable
  
  belongs_to :province
  belongs_to :region
  has_many :caps
  has_many :fractions

  has_one :symbol, :class_name => "DbComuniPicture", as: :picturable, dependent: :destroy

  before_save :set_region_id

  def set_region_id
    self.region_id = self.province.region.id
  end

end