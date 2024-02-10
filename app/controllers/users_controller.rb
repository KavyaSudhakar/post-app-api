class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create]
  def create
    user = User.new(user_params)
    if user.save
      render json: { message: 'User created successfully', api_key: user.api_key }
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      render json: { message: 'Login successful', api_key: user.api_key }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
