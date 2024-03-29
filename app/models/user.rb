# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  confirmation_token :string(128)
#  email              :string           not null
#  encrypted_password :string(128)      not null
#  first_name         :string           not null
#  last_name          :string           not null
#  phone_number       :string           not null
#  remember_token     :string(128)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  stripe_customer_id :string
#
# Indexes
#
#  index_users_on_email           (email)
#  index_users_on_remember_token  (remember_token)
#
class User < ApplicationRecord
  include Clearance::User

  validates :first_name, :last_name, :phone_number, presence: true

  has_one :address, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :address, update_only: true

  after_create :create_stripe_customer

  has_many :bookings, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def create_stripe_customer
    return ActiveModel::Error.new(self, :email, :already_exists) if stripe_customer_already_exists?(email)

    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end

  def stripe_customer_already_exists?(email)
    Stripe::Customer.list(email: email) == email
  end
end
