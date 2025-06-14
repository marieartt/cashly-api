class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :credit_card_id, :description, :amount, :transaction_date, :category
end
