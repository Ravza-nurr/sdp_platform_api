module Api
  module V1
    class ResponsesController < ApplicationController
      before_action :set_response, only: %i[show update destroy]

      # GET /api/v1/responses
      def index
        @responses = Response.all
        render json: @responses, status: :ok
      end

      # GET /api/v1/responses/:id
      def show
        render json: @response, status: :ok
      end

      # POST /api/v1/responses
      def create
        @response = Response.new(response_params)
        if @response.save
          render json: @response, status: :created
        else
          render json: { errors: @response.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT/PATCH /api/v1/responses/:id
      def update
        if @response.update(response_params)
          render json: @response, status: :ok
        else
          render json: { errors: @response.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/responses/:id
      def destroy
        @response.destroy
        head :no_content
      end

      private

      def set_response
        @response = Response.find_by!(id: params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Yanıt bulunamadı." }, status: :not_found
      end

      # Strong Parameters (response_data ve demographic_data JSONB alanları izin verildi)
      def response_params
        params.require(:response).permit(
          :survey_id,
          :participant_id,
          :completed_at,
          :ip_address,
          :device_info,
          :is_complete,
          response_data: {},
          demographic_data: {}
        )
      end
    end
  end
end
