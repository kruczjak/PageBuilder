module Api
  module Projects
    class GitsController < ApplicationController
      before_action :authenticate_user!

      def commit
        g = Git.open(project.project_path.to_s)
        g.add(all: true)
        g.commit("Commit at #{Time.current.to_s}")

        render json: { status: :ok }
      end

      def push
        ProjectPusherWorker.perform_async(project.id)

        render json: { status: :ok }
      end

      def pull
        ProjectPullerWorker.perform_async(project.id)

        render json: { status: :ok }
      end

      def deploy
        ProjectDeployWorker.perform_async(project.id)

        render json: { status: :ok }
      end
    end
  end
end
