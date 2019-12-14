# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  current_sign_in_at  :datetime
#  current_sign_in_ip  :inet
#  email               :string           not null
#  image               :string           not null
#  last_sign_in_at     :datetime
#  last_sign_in_ip     :inet
#  name                :string           not null
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  organization_id     :bigint
#
# Indexes
#
#  index_users_on_email            (email) UNIQUE
#  index_users_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#

class User < ApplicationRecord
  belongs_to :organization, optional: true
  devise(
    :omniauthable,
    :rememberable,
    :trackable,
    omniauth_providers: [:google_oauth2]
  )
end
