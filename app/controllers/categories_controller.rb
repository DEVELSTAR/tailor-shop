class CategoriesController < ApplicationController
  def show
    @category = Category.includes(:products, :galleries).find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render json: @category }
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to galleries_path, alert: 'Category not found.'
  end
end
