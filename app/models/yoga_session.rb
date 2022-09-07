# frozen_string_literal: true

# == Schema Information
#
# Table name: yoga_sessions
#
#  id                     :bigint           not null, primary key
#  end_date               :datetime         not null
#  number_booking         :integer          default(0), not null
#  number_participants    :integer          not null
#  price                  :integer          not null
#  start_date             :datetime         not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  course_id              :bigint
#  stripe_price_id        :string
#  stripe_yoga_session_id :string
#  teacher_id             :bigint
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

  validates :start_date, :end_date, :number_booking,
            :number_participants, :price,
            presence: true

  validates :number_booking, :price, numericality: true

  validates :number_participants, numericality: { greater_than: 0 }

  validate :start_end_on_same_day,
           :start_is_before_end_date,
           :start_in_future,
           :in_between_opening_hours,
           :teacher_availability

  after_create :create_stripe_yoga_session

  def remaining_seats
    number_participants - number_booking
  end

  # callback method
  def create_stripe_yoga_session
    product = Stripe::Product.create(name: course.name, description: start_date.strftime('%d/%m/%Y'))
    product_price = Stripe::Price.create(product: product.id, unit_amount: price, currency: 'eur')
    update_columns(stripe_yoga_session_id: product.id, stripe_price_id: product_price.id)
  end

  # custom validation methods
  def start_end_on_same_day
    return if start_date.to_date == end_date.to_date

    errors.add(:end_date, I18n.t('yoga_sessions.same_day'))
  end

  def start_is_before_end_date
    return if start_date < end_date

    errors.add(:start_date, I18n.t('yoga_sessions.before_end_date'))
  end

  def start_in_future
    return if start_date > Time.zone.now

    errors.add(:start_date, I18n.t('yoga_sessions.must_be_future'))
  end

  def in_between_opening_hours
    valid = [start_date, end_date].all? do |d|
      d.between?(d.change(hour: 7), d.change(hour: 23))
    end
    return if valid

    errors.add(:start_date, I18n.t('yoga_sessions.between_opening_hours'))
  end

  def teacher_availability
    return if teacher.available_between?(start_date, end_date)

    errors.add(:teacher, I18n.t('teachers.teacher_availability'))
  end

  # building stripe line for yoga_session
  def to_stripe_format
    {
      price: stripe_price_id,
      quantity: 1
    }
  end

  def already_booked?(user_id, yoga_session_id)
    return unless Booking.exists?(user_id: user_id, yoga_session_id: yoga_session_id)

    errors.add(:base, :already_booked)
  end
end
