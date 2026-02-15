class ProductsController < ApplicationController
  def show
    @product = Product.includes(:category).find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render json: @product }
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to galleries_path, alert: 'Product not found.'
  end
end
