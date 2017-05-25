class ProjectCreatorWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)

    `cd #{Rails.public_path.join('projects')} && bundle exec middleman init #{project.uuid}`

    project.update_attribute(:initialized_at, Time.current)

    ProjectGeneratorWorker.perform_async(project_id)
  end
end
