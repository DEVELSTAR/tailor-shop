class BookingsController < ApplicationController
  before_action :set_categories_and_products, only: [:new]
  
  def new
    @booking = Booking.new
    @booking.customer = Customer.new
    @booking.booking_items.build
    
    # Pre-fill with express service if coming from product page
    if params[:product_id].present?
      product = Product.find(params[:product_id])
      @booking.booking_items.build(product: product, quantity: 1, price: product.price)
    end
  end
  
  def create
    @booking = Booking.new(booking_params)
    
    # Find or create customer
    customer_params = params[:booking].delete(:customer_attributes)
    @booking.customer = find_or_create_customer(customer_params)
    
    if @booking.save
      @booking.update_total!
      
      # Send confirmation email (you can implement this later)
      # BookingMailer.confirmation(@booking).deliver_later
      
      redirect_to root_path(anchor: 'contact'), 
                  notice: 'Booking request submitted successfully! We will contact you shortly to confirm details.'
    else
      set_categories_and_products
      flash.now[:alert] = 'There was an error submitting your booking. Please check the form and try again.'
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_categories_and_products
    @categories = Category.includes(:products).ordered
    @products = Product.includes(:category).all
  end
  
  def find_or_create_customer(customer_params)
    return nil if customer_params.blank?
    
    # Try to find existing customer by phone or email
    customer = Customer.find_by(phone: customer_params[:phone]) if customer_params[:phone].present?
    customer ||= Customer.find_by(email: customer_params[:email]) if customer_params[:email].present?
    
    # If not found, create new customer
    customer ||= Customer.new(customer_params)
    
    # Save customer if it's new and valid
    if customer.new_record? && customer.valid?
      customer.save
    end
    
    customer
  end
  
  def booking_params
    params.require(:booking).permit(
      :booking_date,
      :delivery_date, 
      :notes,
      :customer_attributes => [:name, :email, :phone, :address, :preferences],
      booking_items_attributes: [:id, :product_id, :quantity, :price, :notes, :_destroy]
    )
  end
end
