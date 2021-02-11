class ProductSampleJob < ApplicationJob
  queue_as :default

  def perform(product)
    product.sample_test
  end

end
