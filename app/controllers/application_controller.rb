class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: { status: :error, message: 'Not found' }, status: :not_found
  end
end
