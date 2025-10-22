module Api
  module V1
    class UsersController < ApplicationController
      # CSRF (Cross-Site Request Forgery) korumasını atla, çünkü API only projelerde bu gerekli değildir.
      # skip_before_action :verify_authenticity_token # Eğer Rails bunu otomatik yapmazsa bu satır kullanılabilir.

      # GET /api/v1/users
      def index
        @users = User.all
        render json: @users, status: :ok
      end

      # GET /api/v1/users/:id
      def show
        @user = User.find_by!(id: params[:id])
        render json: @user, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Kullanıcı bulunamadı." }, status: :not_found
      end

      # POST /api/v1/users
      def create
        @user = User.new(user_params)

        # NOTE: Şifre alanı zorunluysa, Devise/Bcrypt ile birlikte çalışması gerekir.
        # Basit bir API simülasyonu için, sadece verileri kaydetme örneği
        @user.encrypted_password = BCrypt::Password.create(params[:user][:password]) if params[:user][:password].present?

        if @user.save
          render json: @user, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT/PATCH /api/v1/users/:id
      def update
        @user = User.find_by!(id: params[:id])
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Kullanıcı bulunamadı." }, status: :not_found
      end

      # DELETE /api/v1/users/:id
      def destroy
        @user = User.find_by!(id: params[:id])
        @user.destroy
        head :no_content # Başarıyla silindi, içerik gönderme
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Kullanıcı bulunamadı." }, status: :not_found
      end

      private

      # Strong Parameters (Güçlü Parametreler)
      # Sadece izin verilen alanların toplu atanmasına izin verir.
      def user_params
        params.require(:user).permit(:email, :name, :institution, :role)
        # encrypted_password ve password ayrı ayrı ele alınır
      end
    end
  end
end
