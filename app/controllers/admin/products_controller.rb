class Admin::ProductsController < AdminController
  before_action :set_product, only: [:edit, :update, :destroy]
  before_action :set_category, only: [:index, :new, :create]

  def index
    @products = @category.products
  end

  def new
    @product = @category.products.new
  end

  def create
    @product = @category.products.new(product_params)
    if @product.save
      redirect_to admin_categories_path, notice: "Product added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_categories_path, notice: "Product updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_categories_path, notice: "Product deleted."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_category
    @category = Category.find(params[:category_id]) if params[:category_id]
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :category_id, :image)
  end
end
