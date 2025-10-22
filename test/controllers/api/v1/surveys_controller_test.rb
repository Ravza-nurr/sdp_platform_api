module Api
  module V1
    class SurveysController < ApplicationController
      before_action :set_survey, only: %i[show update destroy]

      # GET /api/v1/surveys
      def index
        @surveys = Survey.all
        render json: @surveys, status: :ok
      end

      # GET /api/v1/surveys/:id
      def show
        render json: @survey, status: :ok
      end

      # POST /api/v1/surveys
      def create
        @survey = Survey.new(survey_params)
        if @survey.save
          render json: @survey, status: :created
        else
          render json: { errors: @survey.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT/PATCH /api/v1/surveys/:id
      def update
        if @survey.update(survey_params)
          render json: @survey, status: :ok
        else
          render json: { errors: @survey.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/surveys/:id
      def destroy
        @survey.destroy
        head :no_content
      end

      private

      def set_survey
        @survey = Survey.find_by!(id: params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Anket bulunamadı." }, status: :not_found
      end

      # Strong Parameters (settings JSONB alanı izin verildi)
      def survey_params
        params.require(:survey).permit(
          :title,
          :description,
          :scale_id,
          :user_id,
          :status,
          :distribution_mode,
          :start_date,
          :end_date,
          :response_count,
          :target_responses,
          settings: {}
        )
      end
    end
  end
end
