class Product < ApplicationRecord
  belongs_to :site
  has_many :favourite_products
  has_many :favourited_by, through: :favourite_products, source: :user
  def self.search(search_term)
    # joins(:site).where("sites.name LIKE ?","%#{search_term}%") 
    # where('products.name like ?',"%#{search_term}%")
    joins(:site).where("sites.name LIKE :search OR products.name LIKE :search",search:"%#{search_term}%") 
  end

  def sample_test
    puts "Product name #{self.name}"
  end

end
