class CategoriesController < ApplicationController

  private

  def query_params
    advertiser_signed_in? ? { advertiser_id: current_advertiser.id } : {}
  end

  # Returns parameter white list for #create
  def category_params
    params[:advertiser_id] = current_advertiser.id if advertiser_signed_in?
    params.permit *%i[id advertiser_id category_code category_name parent_category_id parent_category_code]
  end

end