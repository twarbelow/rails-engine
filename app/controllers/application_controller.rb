class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def record_not_found
    render status: :not_found
  end

  def record_invalid
    render status: :bad_request
  end
end
