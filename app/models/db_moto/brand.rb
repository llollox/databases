class Brand < ActiveRecord::Base
  include ConnectToDbMoto
  
  has_many :models, :dependent => :delete_all
  has_many :bikes, :dependent => :delete_all

  validates :name, :presence => true
  validates_uniqueness_of :name

  has_one :logo, :class_name => "DbMotoPicture", as: :picturable, dependent: :destroy
  accepts_nested_attributes_for :logo, allow_destroy:true, :reject_if => lambda { |a| a[:photo].blank? }

  scope :alphabetically, -> { order(:name => :asc) }
end
