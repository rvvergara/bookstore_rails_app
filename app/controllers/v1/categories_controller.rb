class V1::CategoriesController < ApplicationController
  before_action :pundit_user
  def create
    @category = Category.new(category_params)
    authorize @category
    if @category.save
      render :category, status: :created
    else
      render_error(@category, "Cannot create category", :unprocessable_entity)
    end
  end

  def update
  end

  def destroy
  end

  private
  
  def category_params
    params.require(:category).permit(:name)
  end
end
