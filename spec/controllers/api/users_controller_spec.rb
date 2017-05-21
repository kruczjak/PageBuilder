require 'rails_helper'

describe Api::UsersController do
  let(:user) { FactoryGirl.create(:user) }
  let(:resp) { Oj.load(response.body) }

  describe '#show' do
    it 'renders 401 when user not signed in' do
      get :show

      expect(response).to have_http_status(401)
    end

    context 'authenticated' do
      before do
        authenticate_user(user)
      end

      it 'renders user correctly' do
        get :show

        expect(response).to have_http_status(200)
        expect(resp).to eq('id' => user.id, 'email' => user.email)
      end
    end
  end
end
