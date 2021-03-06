class CategoriesController < ApplicationController

  def index
    @categories = Category.all

    respond_to do |f|
      f.js {render :json => @categories}
      f.html {render 'index'}
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    redirect_to user_path(User.find(session[:user_id]))
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
