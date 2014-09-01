class Region < ActiveRecord::Base
  include ConnectToDbMunicipalities
  include Searchable

  has_many :provinces
  has_many :municipalities
  has_many :fractions

  has_one :symbol, :class_name => "DbComuniPicture", as: :picturable, dependent: :destroy


  def capital
    Municipality.find self.capital_id
  end
  
end