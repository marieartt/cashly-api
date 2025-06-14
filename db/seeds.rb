# db/seeds.rb

user = User.create!(email: 'user@example.com', password: 'password123', password_confirmation: 'password123', name: 'Test User', nickname: 'testuser', image: 'https://example.com/image.png')

credit_card = CreditCard.create!(
  user: user,
  brand: 'MasterCard',
  number: '5555555555554444',
  expiration_date: '2026-12-31',
  name: 'User Card'
)

5.times do |i|
  Transaction.create!(
    user: user,
    credit_card: credit_card,
    description: 'Academia',
    amount: -150.00,
    transaction_date: DateTime.new(2025, 1, 15, 11, 0, 0),
    category: 'Fitness'
  )
end

Transaction.create!(user: user, credit_card: credit_card, amount: -628.00, description: 'Diversos', transaction_date: Time.now, category: 'Diversos')
Transaction.create!(user: user, credit_card: credit_card, amount: -150.00, description: 'Lugares', transaction_date: Time.now, category: 'Lugares')
Transaction.create!(user: user, credit_card: credit_card, amount: -400.00, description: 'Gasolina', transaction_date: Time.now, category: 'Gasolina')
Transaction.create!(user: user, credit_card: credit_card, amount: -100.00, description: 'Comida', transaction_date: Time.now, category: 'Comida')
Transaction.create!(user: user, credit_card: credit_card, amount: -65.00, description: 'Uber', transaction_date: Time.now, category: 'Uber')
Transaction.create!(user: user, credit_card: credit_card, amount: -75.00, description: 'Outros', transaction_date: Time.now, category: 'Outros')
Transaction.create!(user: user, credit_card: credit_card, amount: -29.00, description: 'Eu', transaction_date: Time.now, category: 'Eu')
