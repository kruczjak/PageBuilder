class ProjectCreatorWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)

    `cd #{Rails.public_path.join('projects')} && bundle exec middleman init #{project.uuid}`
  end
end
