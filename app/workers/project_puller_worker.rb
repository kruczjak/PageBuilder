class ProjectPullerWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)

    g = Git.open(project.project_path.to_s)
    g.remote('origin').remove if g.remote('origin').url
    g.add_remote('origin', project.project_setting.git_remote_url)

    script = 'eval $(ssh-agent -s);' \
    "echo \"#{project.project_setting.git_sshkey}\" | ssh-add -;" \
    "cd #{project.project_path} && git fetch --all && git reset --hard origin/master;" \
    'ssh-agent -k;' \
    'unset SSH_AUTH_SOCK;' \
    'unset SSH_AGENT_PID;'

    logger.info "Running script: #{script}"

    `#{script}`
  end
end
