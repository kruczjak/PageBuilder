module Api
  class BuildsController < ApplicationController
    skip_before_action :authenticate_user!

    def show
      send_file(project.build_zip, filename: "#{project.name_or_uuid}.zip", type: 'application/zip')
    end

    private

    def project
      @project ||= Project.find_by!(uuid: params[:id])
    end
  end
end
