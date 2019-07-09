class V1::CategoriesController < ApplicationController
  before_action :pundit_user, :admin_only
  def create
    @category = Category.new(category_params)

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

  def admin_only
    if @current_user.access_level < 2
      render_error(nil, "You have to be an admin to do that", :unauthorized)
    end
  end
end
