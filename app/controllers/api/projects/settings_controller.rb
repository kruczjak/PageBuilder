module Api
  module Projects
    class SettingsController < ApplicationController
      before_action :authenticate_user!

      # Renders current settings for project
      def show
        render json: project.project_setting
      end

      # Updates settings for given product
      def update
        project_setting = project.project_setting || project.build_project_setting
        project_setting.attributes = project_setting_params

        if project_setting.save(project_setting_params)
          render json: { status: :ok }
        else
          render json: { status: :error }, status: :unprocessable_entity
        end
      end

      private

      def project_setting_params
        params.require(:settings).permit(:git_remote_url, :git_sshkey)
      end
    end
  end
end