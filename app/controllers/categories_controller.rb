class CategoriesController < ApplicationController

  private

  def query_params
    {}
  end

  def category_params
    params.permit *%i[category_code category_name parent_category_code]
  end

end