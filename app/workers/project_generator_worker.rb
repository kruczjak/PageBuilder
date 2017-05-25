class ProjectGeneratorWorker
  include Sidekiq::Worker

  def perform(project_id, create_zip = true)
    @project = Project.find(project_id)

    `mkdir -p #{build_folder}`

    logger.info "Building and rendering log:"
    logger.info `cd #{project_folder} && bundle exec middleman build --build-dir=#{build_folder}`

    zip_build_files if create_zip

    @project.update_attribute(:built_at, Time.current)
  end

  private

  def zip_build_files
    `rm #{@project.build_zip}`

    zip_command = "cd #{Rails.public_path.join('builds')} && zip -r #{@project.uuid}.zip #{@project.uuid}"
    logger.info "Running: #{zip_command}"
    `#{zip_command}`
  end

  def build_folder
    @project.build_path
  end

  def project_folder
    @project.project_path
  end
end
