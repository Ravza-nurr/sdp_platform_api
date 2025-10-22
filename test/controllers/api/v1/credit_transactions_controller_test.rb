module Api
  module V1
    class CreditTransactionsController < ApplicationController
      before_action :set_credit_transaction, only: %i[show update destroy]

      # GET /api/v1/credit_transactions
      def index
        @credit_transactions = CreditTransaction.all
        render json: @credit_transactions, status: :ok
      end

      # GET /api/v1/credit_transactions/:id
      def show
        render json: @credit_transaction, status: :ok
      end

      # POST /api/v1/credit_transactions
      def create
        @credit_transaction = CreditTransaction.new(credit_transaction_params)
        if @credit_transaction.save
          render json: @credit_transaction, status: :created
        else
          render json: { errors: @credit_transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT/PATCH /api/v1/credit_transactions/:id
      def update
        if @credit_transaction.update(credit_transaction_params)
          render json: @credit_transaction, status: :ok
        else
          render json: { errors: @credit_transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/credit_transactions/:id
      def destroy
        @credit_transaction.destroy
        head :no_content
      end

      private

      def set_credit_transaction
        @credit_transaction = CreditTransaction.find_by!(id: params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Kredi işlemi bulunamadı." }, status: :not_found
      end

      # Strong Parameters
      def credit_transaction_params
        params.require(:credit_transaction).permit(
          :user_id,
          :amount,
          :transaction_type,
          :description,
          :balance_after
        )
      end
    end
  end
end
