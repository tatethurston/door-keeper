# == Schema Information
#
# Table name: doors_codes
#
#  id      :bigint           not null, primary key
#  code_id :bigint           not null
#  door_id :bigint           not null
#
# Indexes
#
#  index_doors_codes_on_code_id              (code_id)
#  index_doors_codes_on_door_id              (door_id)
#  index_doors_codes_on_door_id_and_code_id  (door_id,code_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (code_id => codes.id)
#  fk_rails_...  (door_id => doors.id)
#

class DoorsCode < ApplicationRecord
  belongs_to :code
  belongs_to :door
end
