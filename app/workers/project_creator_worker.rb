class ProjectCreatorWorker
  include Sidekiq::Worker
  COMMIT_MESSAGE = 'Initial commit'.freeze

  def perform(project_id)
    project = Project.find(project_id)

    `cd #{Rails.public_path.join('projects')} && bundle exec middleman init #{project.uuid}`
    `echo "gem 'middleman-gh-pages'" >> #{project.project_path.join('Gemfile')}`
    `cd #{project.project_path} && bundler install`
    `echo "require 'middleman-gh-pages'" >> #{project.project_path.join('Rakefile')}`

    g = Git.init(project.project_path.to_s)
    g.config('user.name', 'PageBuilder')
    g.config('user.email', 'builder@noreply.com')
    g.add(all: true)
    g.commit(COMMIT_MESSAGE)

    project.update_attribute(:initialized_at, Time.current)

    ProjectGeneratorWorker.perform_async(project_id)
  end
end
