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
#
# Indexes
#
#  index_users_on_email           (email)
#  index_users_on_remember_token  (remember_token)
#
class User < ApplicationRecord
  rolify strict: true

  include Clearance::User

  has_one :address

  validates :first_name, :last_name, :phone_number, presence: true

  # TODO: delete once role gem is installed admin/user
  def admin?
    true
  end

  def full_name
    "#{first_name} #{last_name}"
  end
  include Trestle::Auth::ModelMethods
  include Trestle::Auth::ModelMethods::Rememberable
end
