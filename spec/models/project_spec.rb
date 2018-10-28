require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'accessors' do
    it { is_expected.to respond_to(:city_value) }
    it { is_expected.to respond_to(:starts_at) }
    it { is_expected.to respond_to(:ends_at) }
  end

  describe 'reimbursements for projects with only two days' do
    let(:travel_day_low) { Project::RATES[:travel_day_low] }
    let(:travel_day_high) { Project::RATES[:travel_day_high] }

    let(:low_project) { Project.new(
        city_value: :low,
        starts_at: DateTime.parse('2018-10-01'),
        ends_at: DateTime.parse('2018-10-02')
      ) }

    let(:high_project) { Project.new(
        city_value: :high,
        starts_at: DateTime.parse('2018-10-01'),
        ends_at: DateTime.parse('2018-10-02')
      ) }

    context 'when in a low_value city and the only dates are travel dates' do
      it { expect(low_project.reimbursement).to eql(travel_day_low*2) }
    end

    context 'when in a high_value city and the only dates are travel dates' do
      it { expect(high_project.reimbursement).to eql(travel_day_high*2) }
    end
  end

  describe 'reimbursements for projects greater than two days' do
    let(:travel_day_low) { Project::RATES[:travel_day_low] }
    let(:travel_day_high) { Project::RATES[:travel_day_high] }
    let(:full_day_low) { Project::RATES[:full_day_low] }
    let(:full_day_high) { Project::RATES[:full_day_high] }

    let(:low_project) { Project.new(
        city_value: :low,
        starts_at: DateTime.parse('2018-10-01'),
        ends_at: DateTime.parse('2018-10-03')
      ) }

    let(:high_project) { Project.new(
        city_value: :high,
        starts_at: DateTime.parse('2018-10-01'),
        ends_at: DateTime.parse('2018-10-03')
      ) }

    context 'when in a low_value city' do
      let(:reimbursement) { (travel_day_low * 2) + full_day_low }
      it { expect(low_project.reimbursement).to eql(reimbursement) }
    end

    context 'when in a high_value city' do
      let(:reimbursement) { (travel_day_high * 2) + full_day_high }
      it { expect(high_project.reimbursement).to eql(reimbursement) }
    end
  end
end
