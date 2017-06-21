require 'rails_helper'

describe Project do
  let(:project) { FactoryGirl.create(:project) }

  describe '#project_path' do
    it 'is correct' do
      expect(project.project_path).
        to eq(Rails.public_path.join('projects', project.uuid))
    end
  end

  describe '#build_path' do
    it 'is correct' do
      expect(project.build_path).to eq(Rails.public_path.join('builds', project.uuid))
    end
  end

  describe '#build_zip' do
    it 'is correct' do
      expect(project.build_zip).to eq(Rails.public_path.join('builds', "#{project.uuid}.zip"))
    end
  end
end
  