module Api
  module V1
    class ReportsController < ApplicationController
      before_action :set_report, only: %i[show update destroy]

      # GET /api/v1/reports
      def index
        @reports = Report.all
        render json: @reports, status: :ok
      end

      # GET /api/v1/reports/:id
      def show
        render json: @report, status: :ok
      end

      # POST /api/v1/reports
      def create
        @report = Report.new(report_params)
        if @report.save
          render json: @report, status: :created
        else
          render json: { errors: @report.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT/PATCH /api/v1/reports/:id
      def update
        if @report.update(report_params)
          render json: @report, status: :ok
        else
          render json: { errors: @report.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/reports/:id
      def destroy
        @report.destroy
        head :no_content
      end

      private

      def set_report
        @report = Report.find_by!(id: params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Rapor bulunamadı." }, status: :not_found
      end

      # Strong Parameters
      def report_params
        params.require(:report).permit(
          :analysis_id,
          :user_id,
          :format,
          :content,
          :file_path,
          :status
        )
      end
    end
  end
end
