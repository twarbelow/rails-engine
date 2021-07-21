class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from ActiveRecord::RecordInvalid, :with => :record_invalid

  def record_not_found
    render status: 404
  end

  def record_invalid
    render status: 400
  end
end
