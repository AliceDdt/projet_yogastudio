# == Schema Information
#
# Table name: addresses
#
#  id            :bigint           not null, primary key
#  city          :string
#  complementary :string
#  street        :string
#  zip_code      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
end
