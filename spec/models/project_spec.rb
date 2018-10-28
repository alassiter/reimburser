require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'accessors' do
    it { is_expected.to respond_to(:city_value) }
    it { is_expected.to respond_to(:starts_at) }
    it { is_expected.to respond_to(:ends_at) }
  end

  describe 'reimbursement' do
    context 'when in a low_value city and the only dates are travel dates' do
      let(:project) { Project.new(
        city_value: :low,
        starts_at: DateTime.parse('2018-10-01'),
        ends_at: DateTime.parse('2018-10-03')
      ) }

      before do
        project #instantiate the project
      end

      it { expect(project.reimbursement).to eql(90) }
    end
    
  end
end
