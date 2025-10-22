class Api::V1::ReportsController < ApplicationController
  before_action :set_report, only: [ :show, :update, :destroy ]

  # GET /api/v1/reports
  def index
    @reports = Report.all
    render json: @reports
  end

  # GET /api/v1/reports/:id
  def show
    render json: @report
  end

  # POST /api/v1/reports
  def create
    @report = Report.new(report_params)

    if @report.save
      render json: @report, status: :created
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/reports/:id
  def update
    if @report.update(report_params)
      render json: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/reports/:id
  def destroy
    @report.destroy
    head :no_content
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    # Status alanını sadece report sahibi veya admin değiştirebilir
    permitted_params = [ :analysis_id, :format, :content, :file_path ]

    if current_user&.admin? || @report&.user_id == current_user&.id
      permitted_params << :status
    end

    params.require(:report).permit(permitted_params)
  end
end
