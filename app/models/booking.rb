# == Schema Information
#
# Table name: bookings
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#  yoga_session_id :bigint           not null
#
# Indexes
#
#  index_bookings_on_user_id          (user_id)
#  index_bookings_on_yoga_session_id  (yoga_session_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (yoga_session_id => yoga_sessions.id)
#
class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :yoga_session
end
