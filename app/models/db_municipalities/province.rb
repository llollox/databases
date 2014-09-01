class Province < ActiveRecord::Base
  include ConnectToDbMunicipalities

  belongs_to :region
  has_many :municipalities

  has_one :symbol, :class_name => "DbComuniPicture", as: :picturable, dependent: :destroy

  validates :name, presence: true

  def name_with_abbreviation
    self.name + " (" + self.abbreviation + ")"
  end

end