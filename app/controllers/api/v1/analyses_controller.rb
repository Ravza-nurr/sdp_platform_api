class Api::V1::AnalysesController < ApplicationController
  before_action :set_analysis, only: [:show, :update, :destroy]

  # GET /api/v1/analyses
  def index
    @analyses = Analysis.all
    render json: @analyses
  end

  # GET /api/v1/analyses/:id
  def show
    render json: @analysis
  end

  # POST /api/v1/analyses
  def create
    @analysis = Analysis.new(analysis_params)
    
    if @analysis.save
      render json: @analysis, status: :created
    else
      render json: @analysis.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/analyses/:id
  def update
    if @analysis.update(analysis_params)
      render json: @analysis
    else
      render json: @analysis.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/analyses/:id
  def destroy
    @analysis.destroy
    head :no_content
  end

  private

  def set_analysis
    @analysis = Analysis.find(params[:id])
  end

  def analysis_params
    params.require(:analysis).permit(:user_id, :survey_id, :analysis_type, :parameters, :results, :status, :credit_cost, :r_script, :output_file, :error_message)
  end
end
