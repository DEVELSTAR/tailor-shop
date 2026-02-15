class Admin::DashboardController < AdminController
  def index
    @reviews_count = Review.count
    @pending_reviews = Review.where(approved: false).count
    @average_rating = Review.average(:rating).to_f.round(2)
    @business_info = BusinessInfo.first
  end
end
