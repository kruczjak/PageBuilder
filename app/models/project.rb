class Project < ApplicationRecord
  has_one :user

  def save
    self.uuid ||= SecureRandom.uuid
    super
  end
end
