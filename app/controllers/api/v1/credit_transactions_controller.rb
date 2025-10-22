class Api::V1::CreditTransactionsController < ApplicationController
  before_action :set_credit_transaction, only: [:show, :update, :destroy]

  # GET /api/v1/credit_transactions
  def index
    @credit_transactions = CreditTransaction.all
    render json: @credit_transactions
  end

  # GET /api/v1/credit_transactions/:id
  def show
    render json: @credit_transaction
  end

  # POST /api/v1/credit_transactions
  def create
    @credit_transaction = CreditTransaction.new(credit_transaction_params)
    
    if @credit_transaction.save
      render json: @credit_transaction, status: :created
    else
      render json: @credit_transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/credit_transactions/:id
  def update
    if @credit_transaction.update(credit_transaction_params)
      render json: @credit_transaction
    else
      render json: @credit_transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/credit_transactions/:id
  def destroy
    @credit_transaction.destroy
    head :no_content
  end

  private

  def set_credit_transaction
    @credit_transaction = CreditTransaction.find(params[:id])
  end

  def credit_transaction_params
    params.require(:credit_transaction).permit(:user_id, :amount, :transaction_type, :description, :balance_after)
  end
end
