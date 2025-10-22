class Api::V1::ScalesController < ApplicationController
  before_action :set_scale, only: [ :show, :update, :destroy ]

  # GET /api/v1/scales
  def index
    @scales = Scale.all
    render json: @scales
  end

  # GET /api/v1/scales/:id
  def show
    render json: @scale
  end

  # POST /api/v1/scales
  def create
    @scale = Scale.new(scale_params)

    if @scale.save
      render json: @scale, status: :created
    else
      render json: @scale.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/scales/:id
  def update
    if @scale.update(scale_params)
      render json: @scale
    else
      render json: @scale.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/scales/:id
  def destroy
    @scale.destroy
    head :no_content
  end

  private

  def set_scale
    @scale = Scale.find(params[:id])
  end

  def scale_params
    # Status ve usage_count alanlarını sadece scale sahibi veya admin değiştirebilir
    permitted_params = [ :title, :description, :doi_identifier, :version, :language, :category, :total_items, :metadata ]

    if current_user&.admin? || @scale&.creator_id == current_user&.id
      permitted_params += [ :status, :usage_count ]
    end

    params.require(:scale).permit(permitted_params)
  end
end
