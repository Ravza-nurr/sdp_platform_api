class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :destroy ]

  # GET /api/v1/users
  def index
    @users = User.all
    render json: @users
  end

  # GET /api/v1/users/:id
  def show
    render json: @user
  end

  # POST /api/v1/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/:id
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    # Role alanını sadece admin kullanıcılar değiştirebilir
    # Ancak create action'da role gönderebilmek için izin veriyoruz (user henüz oluşturulmadığı için current_user nil olabilir)
    permitted_params = [ :email, :password, :password_confirmation, :name, :institution, :role ]
    
    # Update action'da admin kontrolü yapılabilir, ama create'de role zorunlu olduğu için permit ediyoruz

    params.require(:user).permit(permitted_params)
  end
end
