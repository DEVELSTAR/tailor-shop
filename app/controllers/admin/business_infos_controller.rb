class Admin::BusinessInfosController < AdminController
  def edit
    @business_info = BusinessInfo.find(params[:id])
  end

  def update
    @business_info = BusinessInfo.find(params[:id])
    if @business_info.update(business_info_params)
      redirect_to admin_root_path, notice: "Business info updated."
    else
      render :edit
    end
  end

  private

  def business_info_params
    params.require(:business_info).permit(:name, :address, :phone, :hours, :description)
  end
end
