
# frozen_string_literal: true

# == Schema Information
#
# Table name: yoga_sessions
#
#  id                  :bigint           not null, primary key
#  date                :date             not null
#  number_booking      :integer          not null
#  number_participants :integer          not null
#  price               :float            not null
#  time                :time             not null
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
#  fk_rails_...  (teacher_id => users.id)
#
class YogaSession < ApplicationRecord

  belongs_to :course
  belongs_to :teacher, class_name: 'User'
end
