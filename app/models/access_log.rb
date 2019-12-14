# == Schema Information
#
# Table name: access_logs
#
#  id            :bigint           not null, primary key
#  denied_reason :string
#  success       :boolean          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  code_id       :bigint
#  door_id       :bigint           not null
#
# Indexes
#
#  index_access_logs_on_code_id  (code_id)
#  index_access_logs_on_door_id  (door_id)
#
# Foreign Keys
#
#  fk_rails_...  (code_id => codes.id)
#  fk_rails_...  (door_id => doors.id)
#

class AccessLog < ApplicationRecord
  belongs_to :code, optional: true
  belongs_to :door
end
