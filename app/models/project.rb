class Project < ApplicationRecord
  belongs_to :user

  after_create :schedule_project_creator

  scope :ordered, -> () { order(updated_at: :desc) }

  def name_or_uuid
    name.presence || uuid
  end

  def save(*)
    self.uuid ||= SecureRandom.uuid
    super
  end

  def project_path
    Rails.public_path.join('projects', uuid)
  end

  def build_path
    Rails.public_path.join('builds', uuid)
  end

  def build_zip
    Rails.public_path.join('builds', "#{uuid}.zip")
  end

  private

  def schedule_project_creator
    ProjectCreatorWorker.perform_async(id)
  end
end
