class HomeController < ApplicationController

  around_filter :shopify_session, :except => 'welcome'

  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login/finalize"
  end

  def index
    
    if params[:id]
      @shop=ShopifyAPI::Shop.current
      @product= ShopifyAPI::Product.find(params[:id])
      redirect_to "http://#{request.host_with_port}/home/product?id=#{@product.id}&shop=#{params[:shop]}"
    end
    # get 3 products
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 3})
    # get latest 3 orders
    @orders   = ShopifyAPI::Order.find(:all, :params => {:limit => 3, :order => "created_at DESC" })
  end

  def product
    if request.post?
       @offer=Offer.new(params[:offer])
    if @offer.save
      redirect_to "http://#{request.host_with_port}/home/review?id=#{@offer.id}"
    end
    else
   @offer=Offer.new
   @offer.shop=params[:shop]
   @offer.product_id=params[:id]
  end
  end

    def review
      @offer=Offer.find params[:id]
      @product=ShopifyAPI::Product.find(@offer.product_id)
      @shop =@offer.shop
    end
 

  

end