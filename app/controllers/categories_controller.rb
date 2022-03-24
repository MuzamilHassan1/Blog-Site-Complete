class CategoriesController < ApplicationController
  def new
    @category=Category.new
  end

  def index
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice]="Category was successfully created"
      redirect_to @category
    else
      render 'new'
    end
  end

  def show
    @category=Category.find(params[:id])
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
