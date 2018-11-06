require 'rails_helper'

RSpec.describe ProjectSet, type: :model do
  describe 'projects' do
    let(:project_1) { Project.new() }
    let(:project_2) { Project.new() }
    let(:project_set) { ProjectSet.new(project_1, project_2) }

    it { expect(project_set.projects.count).to eq(2) }
  end

  describe 'build_date_list' do
    # given a set of projects
    # days should be a hash of dates with their value
    let(:project_1) { Project.new(
        city_value: :low,
        starts_at: DateTime.parse('2015-09-01'),
        ends_at: DateTime.parse('2015-09-03')
      ) }

    let(:project_2) { Project.new(
        city_value: :low,
        starts_at: DateTime.parse('2015-09-03'),
        ends_at: DateTime.parse('2015-09-05')
      ) }

    let(:set) { ProjectSet.new(project_1, project_2) }

    it 'builds the right structure' do
      expect(set.build_date_list).to be_a(Hash)
      expect(set.build_date_list.keys.first).to eql(project_1.starts_at)
      expect(set.build_date_list.keys.last).to eql(project_2.ends_at)
    end
  end

  describe 'Set 1' do
    let(:project_1) { Project.new(
        city_value: :low,
        starts_at: DateTime.parse('2015-09-01'),
        ends_at: DateTime.parse('2015-09-03')
      ) }

    let(:set_1) { ProjectSet.new(project_1) }

    it { expect(set_1.reimbursement).to eq(project_1.reimbursement) }
  end

  describe 'Set 2' do
    let(:travel_day_low) { Project::RATES[:travel_day_low] }
    let(:travel_day_high) { Project::RATES[:travel_day_high] }
    let(:full_day_low) { Project::RATES[:full_day_low] }
    let(:full_day_high) { Project::RATES[:full_day_high] }

    let(:project_1) { Project.new(
        city_value: :low,
        starts_at: DateTime.parse('2015-09-01'),
        ends_at: DateTime.parse('2015-09-01')
      ) }

    let(:project_2) { Project.new(
        city_value: :high,
        starts_at: DateTime.parse('2015-09-02'),
        ends_at: DateTime.parse('2015-09-06')
      ) }

    let(:project_3) { Project.new(
        city_value: :low,
        starts_at: DateTime.parse('2015-09-06'),
        ends_at: DateTime.parse('2015-09-08')
      ) }

    let(:set_2) { ProjectSet.new(project_1, project_2, project_3) }

    xcontext 'when calculating reimbursement' do
      let(:reimbursement) { travel_day_low }
    end
  end
end
