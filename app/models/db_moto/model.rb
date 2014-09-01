class Model < ActiveRecord::Base
  include ConnectToDbMoto
  belongs_to :brand
  has_many :bikes

  validates :name, :presence => true
  validates :brand_id, :presence => true

  scope :alphabetically, -> { order(:name => :asc) }
end
