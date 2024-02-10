class ApplicationController < ActionController::API
  before_action :authenticate

  private

  def authenticate
    token = extract_token_from_headers
    @current_user = User.find_by(api_key: token) if token.present?
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end

  def extract_token_from_headers
    request.headers['Authorization']&.split(' ')&.last
  end
end
