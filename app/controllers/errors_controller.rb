class ErrorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render :not_found, status: 404
  end

  def unacceptable
    render status: 422
  end

  def internal_server_error
    render status: 500
  end
end