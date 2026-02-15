class GalleriesController < ApplicationController
  def index
    @galleries = Gallery.includes(:category).featured.recent.limit(12)
    @categories = Category.ordered
  end
  
  def show
    @gallery = Gallery.find(params[:id])
    @related_galleries = Gallery.where(category: @gallery.category)
                                 .where.not(id: @gallery.id)
                                 .recent
                                 .limit(6)
  rescue ActiveRecord::RecordNotFound
    redirect_to galleries_path, alert: 'Gallery item not found.'
  end
end
