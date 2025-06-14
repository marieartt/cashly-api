class CreditCardSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :number, :expiration_date, :name, :brand
end
