module Api
  module Projects
    class GitsController < ApplicationController
      before_action :authenticate_user!

      # Adds commit in project
      def commit
        g = Git.open(project.project_path.to_s)
        g.add(all: true)
        g.commit("Commit at #{Time.current.to_s}")

        render json: { status: :ok }
      end

      # Force pushes project to remote url
      def push
        ProjectPusherWorker.perform_async(project.id)

        render json: { status: :ok }
      end

      # Force pulls project from remote url
      def pull
        ProjectPullerWorker.perform_async(project.id)

        render json: { status: :ok }
      end

      # Deploys project to gh-pages branch automatically
      def deploy
        ProjectDeployWorker.perform_async(project.id)

        render json: { status: :ok }
      end
    end
  end
end
