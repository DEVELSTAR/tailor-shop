class Api::V1::BusinessInfosController < ApplicationController
  def show
    render json: BusinessInfo.first || { error: "No business info found" }
  end
end
