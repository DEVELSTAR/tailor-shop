class ReviewsController < ApplicationController
  def index
    @reviews = Review.where(approved: true).order(created_at: :desc)
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    
    if @review.save
      redirect_to reviews_path, notice: "Review submitted. Thank you! It will appear once approved."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:reviewer_name, :rating, :comment)
  end
end
