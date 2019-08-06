class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  include ActionController::MimeResponds

  respond_to :json

  rescue_from ActionController::ParameterMissing, with: :render_400
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_400
    head :bad_request
  end

  def render_404
    head :not_found
  end

  def current_user
    @current_user ||= User.find(request.headers['user-id'])
  end

  def authenticate_user!
    return if current_user.present?

    render json: {
      errors: [
        status: '401',
        title: 'Unauthorized',
        detail: 'User is not authenticated'
      ]
    }, status: :unauthorized
  end

  def pagination_params
    page_params = params.permit(page: %i[number size])[:page].to_h

    {
      page_number: page_params['number'].to_i,
      page_size: page_params['size'].to_i,
      url: request.original_url
    }
  end

  def respond_with_validation_error(resource, prefix: nil)
    respond_with_error(
      :bad_request,
      resource.errors.messages.map do |k, v|
        k.match?(/\./) ? [k, v] : [:"#{prefix || resource_prefix(resource)}.#{k}", v]
      end.to_h
    )
  end

  def respond_with_error(status, errors)
    render json: {
      errors: errors.map do |k, v|
        {
          source: k.to_s,
          detail: Array(v)
        }
      end
    }, status: status
  end
end
