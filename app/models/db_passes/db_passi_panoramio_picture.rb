class DbPassiPanoramioPicture < ActiveRecord::Base
  include ConnectToDbPasses
  belongs_to :picturable, polymorphic: true
  self.table_name = 'flickr_pictures'
end
