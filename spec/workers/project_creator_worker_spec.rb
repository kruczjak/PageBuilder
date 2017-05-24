require 'rails_helper'

describe ProjectCreatorWorker, type: :worker do
  let(:project) { FactoryGirl.create(:project) }
end
