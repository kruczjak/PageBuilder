require 'rails_helper'

describe Api::BuildsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:resp) { Oj.load(response.body) }

  it 'does\'t require authentication' do
    get :show, params: { id: -1 }

    expect(response).not_to have_http_status(401)
  end
end
