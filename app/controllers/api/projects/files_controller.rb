module Api
  module Projects
    class FilesController < ApplicationController
      before_action :authenticate_user!

      def create
        File.open(file_path, 'w')

        render json: { status: :ok }
      end

      def show
        readed_file = File.read(file_path)

        render json: { content: readed_file }
      end

      def update
        File.open(file_path, 'w') do |file|
          file.write(file_params[:content])
        end

        render json: { status: :ok }
      end

      def destroy
        File.delete(file_path)

        render json: { status: :ok }
      end

      private

      def file_params
        params.require(:file).permit(:content)
      end

      def file_path
        project.project_path.join(params[:id])
      end
    end
  end
end
