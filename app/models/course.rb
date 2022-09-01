# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id                :bigint           not null, primary key
#  long_description  :text             not null
#  name              :string           not null
#  short_description :text             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Course < ApplicationRecord
  has_many :yoga_sessions

  validates :name, :short_description, :long_description,
            presence: true
end
