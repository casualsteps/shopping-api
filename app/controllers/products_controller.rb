class ProductsController < ApplicationController

  private

  def query_params
    {}
  end

  def product_params
    params.permit *%i[product_code product_name product_url image_url price slug]
  end

end