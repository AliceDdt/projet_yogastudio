# frozen_string_literal: true

# == Schema Information
#
# Table name: administrators
#
#  id                        :bigint           not null, primary key
#  email                     :string
#  first_name                :string
#  last_name                 :string
#  password_digest           :string
#  remember_token            :string
#  remember_token_expires_at :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class Administrator < ApplicationRecord
  include Trestle::Auth::ModelMethods
  include Trestle::Auth::ModelMethods::Rememberable

  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
