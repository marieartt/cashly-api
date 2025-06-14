class Goal < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :target_amount, presence: true, numericality: { greater_than: 0 }

  enum :status, {
    pending: 'pending',
    in_progress: 'in_progress',
    achieved: 'achieved',
    failed: 'failed'
  }, default: :pending
end
