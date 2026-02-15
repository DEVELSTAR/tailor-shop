class AdminController < ApplicationController
  before_action :require_authentication
  layout 'admin'
end
