class Site < ApplicationRecord
  has_many :products
  def self.search(search_term)
    where('name like ?',"%#{search_term}%")
    # Product.joins(:site).where(sites:{name:"%#{search_term}%"})
  end
end
