class Admin::CategoriesController < AdminController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.includes(:products).all
  end

  def show
    @products = @category.products
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: "Category created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Category updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: "Category deleted."
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
