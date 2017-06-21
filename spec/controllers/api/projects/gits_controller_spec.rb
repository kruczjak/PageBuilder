require 'rails_helper'

describe Api::Projects::GitsController do
  it_behaves_like 'it requires authenticated user'

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user: user) }

  context 'when authenticated' do
    before do
      authenticate_user(user)
    end

    describe '#pull' do
      it 'renders 200' do
        post :pull, params: { project_id: project.id }

        expect(response).to have_http_status(200)
      end

      it 'calls ProjectPullerWorker' do 
        expect(ProjectPullerWorker).to receive(:perform_async).with(project.id)

        post :pull, params: { project_id: project.id }
      end
    end
  end
end
