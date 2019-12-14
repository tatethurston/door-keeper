# == Schema Information
#
# Table name: codes
#
#  id              :bigint           not null, primary key
#  allowed_time    :string
#  disabled_at     :datetime
#  name            :string           not null
#  value           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_codes_on_organization_id            (organization_id)
#  index_codes_on_organization_id_and_value  (organization_id,value) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#

class Code < ApplicationRecord
  belongs_to :organization
  has_many :doors_codes
  has_many :doors, through: :doors_codes

  has_paper_trail
end
