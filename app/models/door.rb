# == Schema Information
#
# Table name: doors
#
#  id              :bigint           not null, primary key
#  name            :string           not null
#  phone_number    :string           not null
#  timezone        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_doors_on_organization_id  (organization_id)
#  index_doors_on_phone_number     (phone_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#

class Door < ApplicationRecord
  belongs_to :organization
  has_many :doors_codes
  has_many :codes, through: :doors_codes
end
