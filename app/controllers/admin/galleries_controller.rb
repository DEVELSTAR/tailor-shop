class Admin::GalleriesController < AdminController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit, :create, :update]
  
  def index
    @galleries = Gallery.includes(:category).recent.page(params[:page]).per(25)
    
    if params[:category_id].present?
      @galleries = @galleries.where(category_id: params[:category_id])
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @galleries }
    end
  end
  
  def show
  end
  
  def new
    @gallery = Gallery.new
  end
  
  def create
    @gallery = Gallery.new(gallery_params)
    
    if @gallery.save
      redirect_to admin_gallery_path(@gallery), notice: 'Gallery item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @gallery.update(gallery_params)
      redirect_to admin_gallery_path(@gallery), notice: 'Gallery item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @gallery.destroy
    redirect_to admin_galleries_path, notice: 'Gallery item was successfully deleted.'
  end
  
  def toggle_featured
    @gallery = Gallery.find(params[:id])
    @gallery.update!(featured: !@gallery.featured)
    
    render json: { 
      success: true, 
      featured: @gallery.featured,
      message: "Gallery item #{@gallery.featured ? 'featured' : 'unfeatured'}"
    }
  end
  
  private
  
  def set_gallery
    @gallery = Gallery.includes(:category).find(params[:id])
  end
  
  def set_categories
    @categories = Category.ordered
  end
  
  def gallery_params
    params.require(:gallery).permit(:title, :description, :category_id, :featured, :image)
  end
end
