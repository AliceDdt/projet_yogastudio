class User < ApplicationRecord
  include Clearance::User

  validates :first_name, :last_name, :phone_number, presence: true
end
