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

  has_many :bookings, dependent: :destroy

  validate :start_end_on_same_day,
           :start_is_before_end_date,
           :start_in_future,
           :in_between_opening_hours,
           :teacher_availability

  def remaining_seats
    number_participants - number_booking
  end

  def start_end_on_same_day
    return if start_date.to_date == end_date.to_date

    errors.add(:end_date, 'must be the same day as start date')
  end

  def start_is_before_end_date
    return if start_date < end_date

    errors.add(:start_date, 'must be before end date')
  end

  def start_in_future
    return if start_date > Time.zone.now

    errors.add(:start_date, 'must be in the future')
  end

  def in_between_opening_hours
    valid = [start_date, end_date].all? do |d|
      d.between?(d.change(hour: 7), d.change(hour: 23))
    end
    return if valid

    errors.add(:start_date, 'must be in between opening hours')
  end

  def teacher_availability
    return if teacher.available_between?(start_date, end_date)

    errors.add(:teacher, 'is not available')
  end

  def to_stripe_format
    {
      price_data: {
        currency: 'eur',
        product_data: {
          name: course.name,
        },
        unit_amount: price.to_i * 100,
      },
      quantity: 1,
    }
  end


end
