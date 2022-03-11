class Admin::CategoriesController < ApplicationController

  http_basic_authenticate_with :name => ENV["ADMIN_USER"], :password => ENV["ADMIN_PASS"]
  
  def index
    @categories = Category.all
  end
end