class Admin::ReviewsController < AdminController
  def index
    @reviews = Review.order(created_at: :desc)
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(approved: !@review.approved)
      redirect_to admin_reviews_path, notice: "Review status updated."
    else
      redirect_to admin_reviews_path, alert: "Failed to update review status."
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_reviews_path, notice: "Review deleted."
  end
end
