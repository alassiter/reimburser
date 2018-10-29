require 'rails_helper'

RSpec.describe ProjectSet, type: :model do
  describe 'projects' do
    let(:project_1) { Project.new() }
    let(:project_2) { Project.new() }
    let(:project_set) { [project_1, project_2] }

    it { expect(project_set.count).to eq(2) }
  end
end
