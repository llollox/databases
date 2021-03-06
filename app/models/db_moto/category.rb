class Category < ActiveRecord::Base
  include ConnectToDbMoto
  validates :name, :presence => true
  has_many :bikes

  def self.search word
    Category.all.each do |category|
      return category if category.name.downcase == word.downcase
    end
    return nil
  end
end
