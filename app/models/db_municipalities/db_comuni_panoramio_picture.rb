class DbComuniPanoramioPicture < ActiveRecord::Base
  include ConnectToDbMunicipalities
  belongs_to :picturable, polymorphic: true
  self.table_name = 'flickr_pictures'
end
