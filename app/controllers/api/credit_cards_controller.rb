class Api::CreditCardsController < ApplicationController
  before_action :set_credit_card, only: [:show, :update, :destroy]
  before_action :authenticate_request!

  # GET /credit_cards
  def index
    @credit_cards = current_user.credit_cards
    render json: @credit_cards, each_serializer: CreditCardSerializer
  end

  # GET /credit_cards/:id
  def show
    render json: @credit_card, serializer: CreditCardSerializer
  end

  # POST /credit_cards/:id
  def create
    @credit_card = CreditCard.new(credit_card_params.merge(user_id: current_user.id))
    if @credit_card.save
      render json: { credit_card: @credit_card }, status: :created
    else
      render json: ErrorSerializer.serialize(@credit_card.errors), status: :unprocessable_entity
    end
  end

  # PUT/PATCH /credit_cards/:id
  def update
    if @credit_card.update(credit_card_params)
      render json: @credit_card, serializer: CreditCardSerializer
    else
      render json: ErrorSerializer.serialize(@credit_card.errors), status: :unprocessable_entity
    end
  end

  # DELETE /credit_cards/:id
  def destroy
    @credit_card.destroy
    head :no_content
  end

  private

  def set_credit_card
    @credit_card = CreditCard.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Cartão de crédito não encontrado' }, status: :not_found
  end

  def credit_card_params
    params.require(:credit_card).permit(
      :id, :user_id, :number, :expiration_date, :name, :brand
    )
  end
end
