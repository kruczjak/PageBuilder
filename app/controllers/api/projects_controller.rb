module Api
  class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_project, only: %i(show destroy update directory_tree regenerate)

    # Creates project and renders errors if any
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
    # @return [Array of serialized Projects]
    def index
      render json: current_user.projects.ordered
    end

    # Renders project owned by current_user   
    # @return [serialized Project]
    def show
      render json: @project
    end

    # Renders whole directory tree
    def directory_tree
      hash = directory_hash(@project.project_path, @project.name)
      hash[:isExpanded] = true

      render json: Oj.dump(hash.deep_stringify_keys)
    end

    # Starts project regenerating in background
    def regenerate
      ProjectGeneratorWorker.perform_async(@project.id)

      render json: { status: :ok }
    end

    private

    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:id, :name)
    end

    def directory_hash(path, name=nil)
      data = { id: next_index, name: (name || path.to_s) }
      data[:children] = children = []

      Dir.foreach(path) do |entry|
        next if entry == '..' || entry == '.'

        full_path = File.join(path, entry)
        if File.directory?(full_path)
          children << directory_hash(full_path, entry)
        else
          children << { id: next_index, name: entry }
        end
      end

      data
    end

    def next_index
      @next_index ||= 0
      @next_index += 1
    end
  end
end
