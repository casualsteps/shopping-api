class ProductsController < ApplicationController

  private

  def query_params
    advertiser_signed_in? ? { advertiser_id: current_advertiser.id } : {}
  end

  # Returns parameter white list for #create
  def product_params
    params[:advertiser_id] = current_advertiser.id if advertiser_signed_in?
    params.permit *%i[id advertiser_id product_code product_name product_url image_url price slug]
  end
end