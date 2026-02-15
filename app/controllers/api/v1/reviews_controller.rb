class Api::V1::ReviewsController < ApplicationController
  def index
    render json: Review.where(approved: true).order(created_at: :desc)
  end
end
