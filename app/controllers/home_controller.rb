class HomeController < ApplicationController
  def index
    @business_info = BusinessInfo.first || BusinessInfo.new(
      name: "Fashion Paradise Ladies Tailor",
      address: "123 Fashion St",
      phone: "555-0123",
      hours: "Mon-Sat 9am-9pm",
      description: "Expert tailoring for ladies."
    )
    @categories = Category.includes(:products).all
    @reviews = Review.where(approved: true).order(created_at: :desc)
    @review = Review.new
    
    if @reviews.any?
      @average_rating = @reviews.average(:rating).round(1)
      @total_reviews = @reviews.count
    else
      @average_rating = 0
      @total_reviews = 0
    end

    set_meta_tags title: @business_info.name,
                  description: @business_info.description,
                  keywords: "tailor, ladies tailor, fashion paradise, stitching, alterations",
                  og: {
                    title: @business_info.name,
                    description: @business_info.description,
                    type: 'website',
                    image: '/icon.png'
                  },
                  twitter: {
                    card: "summary",
                    title: @business_info.name,
                    description: @business_info.description
                  }
  end
end
