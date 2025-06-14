class User < ActiveRecord::Base
  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one :user_detail, dependent: :destroy
  has_many :credit_cards, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :goals, dependent: :destroy

  validates :password, :password_confirmation, presence: true, on: :create

  after_create :create_user_details

  attr_accessor :phone, :birthdate
  
  accepts_nested_attributes_for :user_detail

  private
  
  def create_user_details
    UserDetail.create(user: self, phone: phone, birthdate: birthdate) if user_detail.nil? 
  end
end
