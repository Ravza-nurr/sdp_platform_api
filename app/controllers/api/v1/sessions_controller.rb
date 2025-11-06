class Api::V1::SessionsController < ApplicationController
  # Authentication endpoint'i - Postman testleri için
  # POST /api/v1/sessions (login)
  # DELETE /api/v1/sessions (logout)
  
  skip_before_action :authenticate_request, only: [:create]

  # POST /api/v1/sessions
  # Login - email ve password ile authentication
  def create
    @user = User.find_by(email: params[:email])
    
    if @user && @user.authenticate(params[:password])
      # Basit token üretimi (gerçek projede JWT kullanılmalı)
      token = SecureRandom.hex(32)
      
      # User model'inde api_token field'ı varsa güncelle
      if @user.respond_to?(:api_token=)
        @user.update(api_token: token)
      end
      
      render json: {
        message: "Login successful",
        user: {
          id: @user.id,
          email: @user.email,
          name: @user.name,
          role: @user.role
        },
        token: token
      }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  # DELETE /api/v1/sessions
  # Logout - token'ı temizle
  def destroy
    if current_user && current_user.respond_to?(:api_token=)
      current_user.update(api_token: nil)
      render json: { message: "Logged out successfully" }, status: :ok
    else
      render json: { message: "No active session" }, status: :ok
    end
  end
end
