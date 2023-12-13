class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.categories
    @user = current_user
    @categories = @user.categories
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
  end
  def edit
    @category = Category.find(params[:id])
  end
  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to '/dashboard'
    else
      render :new
    end
  end
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to new_category_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  private


  def category_params
    params.require(:category).permit(:categories_name, :description)
  end

  def authenticate_user!
    redirect_to '/' unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
