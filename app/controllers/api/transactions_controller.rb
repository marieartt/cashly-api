class Api::TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]

  # GET /transactions
  def index
    @transactions = current_user.transactions
    if params[:filter].present?
      @transactions = @transactions.where(credit_card_id: params[:filter][:credit_card_id]) if params[:filter][:credit_card_id].present?
    end

    render json: @transactions, each_serializer: TransactionSerializer
  end

  # GET /transactions/:id
  def show
    render json: @transaction, serializer: TransactionSerializer
  end

  # POST /transactions/:id
  def create
    @transaction = Transaction.new(transaction_params.merge(user_id: current_user.id))
    if @transaction.save
      render json: @transaction, serializer: TransactionSerializer, status: :created
    else
      render json: ErrorSerializer.serialize(@transaction.errors), status: :unprocessable_entity
    end
  end

  # PUT/PATCH /transactions/:id
  def update
    if @transaction.update(transaction_params.merge(user_id: current_user.id))
      render json: @transaction, serializer: TransactionSerializer
    else
      render json: ErrorSerializer.serialize(@transaction.errors), status: :unprocessable_entity
    end
  end

  # DELETE /transactions/:id
  def destroy
    @transaction.destroy
    head :no_content
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Transação não encontrada' }, status: :not_found
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :transaction_date, :category, :credit_card_id)
  end
end
