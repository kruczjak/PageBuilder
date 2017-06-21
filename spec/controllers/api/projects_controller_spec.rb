require 'rails_helper'

describe Api::ProjectsController do
  it_behaves_like 'it requires authenticated user'

  let(:user) { FactoryGirl.create(:user) }
  let(:resp) { Oj.load(response.body) }
end
