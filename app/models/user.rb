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

  has_one :address, as: :addressable, dependent: :destroy

  validates :first_name, :last_name, :phone_number, presence: true

  accepts_nested_attributes_for :address, update_only: true

  # TODO: delete once role gem is installed admin/user
  def admin?
    true
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  after_create do
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end
end
