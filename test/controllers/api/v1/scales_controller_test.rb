module Api
  module V1
    class ScalesController < ApplicationController
      # skip_before_action :verify_authenticity_token # Eğer Rails bunu otomatik yapmazsa bu satır kullanılabilir.

      # GET /api/v1/scales
      def index
        # Yayınlanmış (published) ölçekleri veya kullanıcıya ait ölçekleri gösterme mantığı buraya gelebilir.
        @scales = Scale.all
        render json: @scales, status: :ok
      end

      # GET /api/v1/scales/:id
      def show
        @scale = Scale.find_by!(id: params[:id])
        render json: @scale, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Ölçek bulunamadı." }, status: :not_found
      end

      # POST /api/v1/scales
      def create
        @scale = Scale.new(scale_params)
        if @scale.save
          render json: @scale, status: :created
        else
          render json: { errors: @scale.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT/PATCH /api/v1/scales/:id
      def update
        @scale = Scale.find_by!(id: params[:id])
        if @scale.update(scale_params)
          render json: @scale, status: :ok
        else
          render json: { errors: @scale.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Ölçek bulunamadı." }, status: :not_found
      end

      # DELETE /api/v1/scales/:id
      def destroy
        @scale = Scale.find_by!(id: params[:id])
        @scale.destroy
        head :no_content
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Ölçek bulunamadı." }, status: :not_found
      end

      private

      # Strong Parameters (Güçlü Parametreler)
      def scale_params
        params.require(:scale).permit(
          :title, 
          :description, 
          :doi_identifier, 
          :version, 
          :language, 
          :category, 
          :total_items, 
          :creator_id, 
          :status, 
          :usage_count, 
          metadata: {} # JSONB alanı için izin
        )
      end
    end
  end
end
