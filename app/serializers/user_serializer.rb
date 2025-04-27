class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at, :updated_at, :phone, :birthdate

  def phone
    object.user_detail.phone if object.user_detail
  end

  def birthdate
    object.user_detail.birthdate if object.user_detail
  end
end
