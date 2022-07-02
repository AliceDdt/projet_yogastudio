# frozen_string_literal: true

# == Schema Information
#
# Table name: yoga_sessions
#
#  id                  :bigint           not null, primary key
#  end_date            :datetime         not null
#  number_booking      :integer          default(0), not null
#  number_participants :integer          not null
#  price               :float            not null
#  start_date          :datetime         not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  course_id           :bigint
#  teacher_id          :bigint
#
# Indexes
#
#  index_yoga_sessions_on_course_id   (course_id)
#  index_yoga_sessions_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (teacher_id => teachers.id)
#
class YogaSession < ApplicationRecord
  belongs_to :course
  belongs_to :teacher

  has_many :bookings

  def remaining_seats
    number_participants - number_booking
  end
end
