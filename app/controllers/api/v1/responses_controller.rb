class Api::V1::ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :update, :destroy]

  # GET /api/v1/responses
  def index
    @responses = Response.all
    render json: @responses
  end

  # GET /api/v1/responses/:id
  def show
    render json: @response
  end

  # POST /api/v1/responses
  def create
    @response = Response.new(response_params)
    
    if @response.save
      render json: @response, status: :created
    else
      render json: @response.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/responses/:id
  def update
    if @response.update(response_params)
      render json: @response
    else
      render json: @response.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/responses/:id
  def destroy
    @response.destroy
    head :no_content
  end

  private

  def set_response
    @response = Response.find(params[:id])
  end

  def response_params
    params.require(:response).permit(:survey_id, :participant_id, :response_data, :demographic_data, :completed_at, :ip_address, :device_info, :is_complete)
  end
end
