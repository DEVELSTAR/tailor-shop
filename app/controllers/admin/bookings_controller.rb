class Admin::BookingsController < AdminController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_customers_and_products, only: [:new, :edit, :create, :update]
  
  def index
    @bookings = Booking.includes(:customer, :booking_items, :products).recent
    
    if params[:status].present?
      @bookings = @bookings.where(status: params[:status])
    end
    
    @bookings = @bookings.page(params[:page]).per(25)
    
    respond_to do |format|
      format.html
      format.json { render json: @bookings }
    end
  end
  
  def show
    @booking_items = @booking.booking_items.includes(:product)
  end
  
  def new
    @booking = Booking.new
    @booking.booking_items.build
  end
  
  def create
    @booking = Booking.new(booking_params)
    @booking.customer = Customer.find(params[:booking][:customer_id]) if params[:booking][:customer_id].present?
    
    if @booking.save
      @booking.update_total!
      redirect_to admin_booking_path(@booking), notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @booking.update(booking_params)
      @booking.update_total!
      redirect_to admin_booking_path(@booking), notice: 'Booking was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @booking.destroy
    redirect_to admin_bookings_path, notice: 'Booking was successfully deleted.'
  end
  
  def update_status
    @booking = Booking.find(params[:id])
    new_status = params[:status]
    
    if @booking.update(status: new_status)
      render json: { success: true, message: "Status updated to #{new_status}" }
    else
      render json: { success: false, message: "Failed to update status" }
    end
  end
  
  private
  
  def set_booking
    @booking = Booking.includes(:customer, :booking_items, :products).find(params[:id])
  end
  
  def set_customers_and_products
    @customers = Customer.order(:name)
    @products = Product.includes(:category).order('categories.name, products.name')
  end
  
  def booking_params
    params.require(:booking).permit(
      :customer_id, 
      :status, 
      :booking_date, 
      :delivery_date, 
      :notes,
      booking_items_attributes: [:id, :product_id, :quantity, :price, :notes, :_destroy]
    )
  end
end
