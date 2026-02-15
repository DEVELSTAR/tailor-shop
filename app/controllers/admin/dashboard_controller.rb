class Admin::DashboardController < AdminController
  def index
    # Basic stats
    @reviews_count = Review.count
    @pending_reviews = Review.pending.count
    @average_rating = Review.average_rating
    @business_info = BusinessInfo.first
    
    # Booking stats
    @total_bookings = Booking.count
    @active_bookings = Booking.active.count
    @completed_bookings = Booking.where(status: :completed).count
    @today_bookings = Booking.where(booking_date: Date.current).count
    
    # Customer stats
    @total_customers = Customer.count
    @new_customers_this_month = Customer.where(created_at: Date.current.all_month).count
    
    # Revenue stats
    # Revenue stats
    @total_revenue = Booking.where(status: :completed, created_at: 30.days.ago..Date.current)
                  .sum(:total_price).to_f
    @this_month_revenue = Booking.where(status: :completed, created_at: Date.current.all_month).sum(:total_price)
    
    # Product stats
    @total_products = Product.count
    @featured_products = Product.featured.count
    
    # Recent activities
    @recent_bookings = Booking.includes(:customer).recent.limit(5)
    @recent_reviews = Review.recent.limit(5)
    @recent_customers = Customer.recent.limit(5)
    
    # Chart data
    @booking_chart_data = booking_chart_data
    @revenue_chart_data = revenue_chart_data
    @rating_distribution = Review.rating_distribution
  end
  
  private
  
  def booking_chart_data
    bookings = Booking.where(created_at: 30.days.ago..Date.current)
                    .group("DATE(created_at)")
                    .count
    
    labels = []
    data = []
    
    (30.days.ago.to_date..Date.current).map do |date|
      date_key = date.strftime("%Y-%m-%d")
      labels << date.strftime("%b %d")
      data << (bookings[date_key] || 0)
    end
    
    {
      labels: labels,
      data: data
    }.to_json
  end
  
  def revenue_chart_data
    revenue = Booking.where(status: :completed, created_at: 30.days.ago..Date.current)
                  .group("DATE(created_at)")
                  .sum(:total_price)
    
    labels = []
    data = []
    
    (30.days.ago.to_date..Date.current).map do |date|
      date_key = date.strftime("%Y-%m-%d")
      labels << date.strftime("%b %d")
      data << (revenue[date_key] || 0)
    end
    
    {
      labels: labels,
      data: data
    }.to_json
  end
end
