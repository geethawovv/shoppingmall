class ProductsController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:search_term]
    # binding.pry
      @products = Product.includes(:site).search(params[:search_term])
      respond_to do |format|
        format.js
      end
    else
      @products = Product.includes(:site).all
      respond_to do |format|
        format.html
      end
    end
  end

  def new
    @product = Product.new
  end

  def create
    binding.pry
    @product = Product.new(product_params)
    @user = current_user
    if @product.save
      # ProductMailer.delay(priority: 20 ,run_at: 5.minutes.from_now).sample_email(@product,current_user)
      # Delayed::Job.enqueue(ProductMailer.sample_email(@product,@user).deliver, :run_at =>  Time.now)
      flash[:notice] = "product saved successfully"
      redirect_to @product
    else
      flash[:alert] = "unable to save product"
      redirect_to products_path
    end
  end

  def show
    @product = Product.find(params[:id])
  end
  
  def favourite
    type = params[:type]
    if type == "favourite"
      @product = Product.find(params[:id])
      current_user.favourites << @product
      ProductMailer.delay(run_at: @product.sale_time - 30.minutes).sample_email(@product,current_user)
      flash[:notice] = "you favourited the #{@product.name}"
      redirect_back(fallback_location: product_path(@product))
    elsif type == "unfavourite"
      @product = Product.find(params[:id])
      current_user.favourites.delete(@product)
      flash[:notice] = "you unfavourited  the #{@product.name}"
      redirect_back(fallback_location: product_path(@product))
    else
      flash[:notice] = "nothing happend"
      redirect_back(fallback_location: product_path(@product))
    end
  end

  private
  def product_params
    params.require(:product).permit(:name,:sale_time).merge(site_id:3)
  end

end
