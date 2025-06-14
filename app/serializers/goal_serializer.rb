class GoalSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :target_amount, :current_amount, :target_date, :status, :description
end
