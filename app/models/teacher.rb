# frozen_string_literal: true

# == Schema Information
#
# Table name: teachers
#
#  id           :bigint           not null, primary key
#  bio          :text
#  email        :string           not null
#  first_name   :string           not null
#  last_name    :string           not null
#  phone_number :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Teacher < ApplicationRecord
  # Relations
  has_one_attached :picture

  has_one :address, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :address, update_only: true

  has_many :yoga_sessions, dependent: :destroy

  # Validations
  validates :last_name, :first_name,
            :bio, :phone_number,
            presence: true

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates_associated :address, presence: true

  validates :picture,
            attached: true,
            content_type: %i[png jpg jpeg],
            size: { less_than: 15.megabytes, message: 'picture is too large' }

  def full_name
    "#{first_name} #{last_name}"
  end

  def available_between?(start_date, end_date)
    yoga_sessions.where('(start_date, end_date) OVERLAPS (?, ?)', start_date, end_date).empty?
  end
end
