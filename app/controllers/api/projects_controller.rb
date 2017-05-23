module Api
  class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_project, only: %i(show destroy update)

    def create
      project = Project.new(project_params)
      project.user = current_user

      if project.save
        render json: { status: :ok }
      else
        render json: project.errors, status: 422
      end
    end

    # Renders project owned by current_user
    def index
      render json: current_user.projects
    end

    # Renders project owned by current_user
    # @return [serialized Project]
    def show
      render json: @project
    end

    private

    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:id, :name)
    end
  end
end
