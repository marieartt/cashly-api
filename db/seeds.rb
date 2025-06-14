ActiveRecord::Base.transaction do
  puts "🧹 Limpando dados…"
  Transaction.delete_all
  CreditCard.delete_all
  Goal.delete_all
  UserDetail.delete_all
  User.delete_all
  ExpenseCategory.delete_all

  # --------------------------------------------------------------------------
  # 1. Usuário demo
  # --------------------------------------------------------------------------
  user = User.create!(
    name:                  "Maria Anita",
    email:                 "demo@cashly.app",
    password:              "12345678",
    password_confirmation: "12345678",
    confirmed_at:          Time.current
  )
  detail = user.user_detail
  UserDetail.create!(
    user:      user,
    phone:     "(11) 98765-4321",
    birthdate: Date.new(1995, 8, 14)
  ) if detail.nil?
  puts "✅ Usuário criado: #{user.email} / 12345678"

  # --------------------------------------------------------------------------
  # 2. Categorias de despesas
  # --------------------------------------------------------------------------
  categories = %w[
    Alimentação Transporte Saúde Educação Lazer Compras Contas Investimentos Outros
  ]
  palette = %w[#EF4444 #3B82F6 #10B981 #F59E0B #A855F7 #EC4899 #6366F1 #14B8A6 #FB923C]
  categories.each_with_index do |cat, idx|
    ExpenseCategory.create!(name: cat, color: palette[idx])
  end
  puts "🎨 Categorias criadas (#{categories.size})"

  # --------------------------------------------------------------------------
  # 3. Cartões de crédito
  # --------------------------------------------------------------------------
  visa   = CreditCard.create!(
    user:            user,
    number:          "4916 6415 1234 5678",
    name:            "Visa Gold",
    brand:           "Visa",
    expiration_date: Date.new(2028, 12, 31)
  )
  master = CreditCard.create!(
    user:            user,
    number:          "5454 3311 9876 5432",
    name:            "Master Black",
    brand:           "Mastercard",
    expiration_date: Date.new(2029, 4, 30)
  )
  puts "💳 Cartões criados"

  # --------------------------------------------------------------------------
  # 4. Transações 2025-01-01 → hoje
  # --------------------------------------------------------------------------
  start_date = Date.new(2025, 1, 1)
  end_date   = Date.current
  rng        = Random.new(42)

  (start_date..end_date).select(&:beginning_of_month).each do |month_start|
    8.times do
      tx_date  = Faker::Time.between(from: month_start, to: month_start.end_of_month, format: :default)
      cat_name = categories.sample
      Transaction.create!(
        user:            user,
        credit_card:     rng.rand < 0.5 ? visa : master,
        description:     Faker::Commerce.product_name,
        amount:          (rng.rand(10..500) * (rng.rand < 0.9 ? -1 : 1)), # 90 % despesa, 10 % renda
        transaction_date: tx_date,
        category:        cat_name
      )
    end
  end
  puts "🔄 Transações geradas: #{Transaction.count}"

  # --------------------------------------------------------------------------
  # 5. Metas financeiras
  # --------------------------------------------------------------------------
  Goal.create!(
    user:           user,
    name:           "Férias Europa 2026",
    description:    "14 dias na Itália + França",
    target_amount:  25_000,
    current_amount: 7_500,
    target_date:    Date.new(2026, 6, 1),
    status:         "in_progress"
  )
  Goal.create!(
    user:           user,
    name:           "Reserva de Emergência",
    description:    "6 meses de despesas fixas",
    target_amount:  30_000,
    current_amount: 18_000,
    target_date:    Date.new(2025, 12, 31),
    status:         "in_progress"
  )
  puts "🎯 Metas criadas"
end

puts "🌱 Seed finalizado!"
