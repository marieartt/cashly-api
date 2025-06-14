class CreditCard < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
end
