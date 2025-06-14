class Api::DashboardController < ApplicationController
  def summary
    user = current_user
    credit_card_id = params[:filter].try(:[], :credit_card_id)

    credit_cards = user.credit_cards.select(:id, :brand, :number)
    transactions = user.transactions.order(transaction_date: :desc).limit(5)
    transactions = transactions.where(credit_card_id: credit_card_id) if credit_card_id.present?

    expenses_summary = user.transactions
                           .where('transaction_date >= ?', Time.now.beginning_of_month)
                           .group(:category)
                           .sum(:amount)

    total_balance = user.transactions.sum(:amount)

    render json: {
      credit_cards: credit_cards.map { |card|
        {
          id: card.id,
          brand: card.brand,
          last_digits: card.number.last(4)
        }
      },
      transactions: transactions.as_json(only: [:id, :description, :amount, :transaction_date]),
      expenses_summary: expenses_summary.map { |category, amount| { category: category, amount: amount.abs } },
      total_balance: total_balance
    }
  end
end
