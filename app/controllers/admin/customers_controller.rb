class Admin::CustomersController < AdminController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  
  def index
    @customers = Customer.includes(:bookings).recent.page(params[:page]).per(25)
    
    respond_to do |format|
      format.html
      format.json { render json: @customers }
    end
  end
  
  def show
    @recent_bookings = @customer.bookings.includes(:booking_items, :products).recent.limit(10)
  end
  
  def new
    @customer = Customer.new
  end
  
  def create
    @customer = Customer.new(customer_params)
    
    if @customer.save
      redirect_to admin_customer_path(@customer), notice: 'Customer was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: 'Customer was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @customer.destroy
    redirect_to admin_customers_path, notice: 'Customer was successfully deleted.'
  end
  
  private
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
  
  def customer_params
    params.require(:customer).permit(:name, :email, :phone, :address, :preferences)
  end
end
