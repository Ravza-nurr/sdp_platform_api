class Api::V1::SurveysController < ApplicationController
  before_action :set_survey, only: [ :show, :update, :destroy ]

  # GET /api/v1/surveys
  def index
    @surveys = Survey.all
    render json: @surveys
  end

  # GET /api/v1/surveys/:id
  def show
    render json: @survey
  end

  # POST /api/v1/surveys
  def create
    @survey = Survey.new(survey_params)

    if @survey.save
      render json: @survey, status: :created
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/surveys/:id
  def update
    if @survey.update(survey_params)
      render json: @survey
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/surveys/:id
  def destroy
    @survey.destroy
    head :no_content
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def survey_params
    params.require(:survey).permit(:title, :description, :scale_id, :user_id, :status, :distribution_mode, :start_date, :end_date, :response_count, :target_responses, :settings)
  end
end
