class Profile < ApplicationRecord
  belongs_to :user

  after_create :set_profile_id_on_user

  private

  def set_profile_id_on_user
    user.update(profile_id: id)
  end
end
