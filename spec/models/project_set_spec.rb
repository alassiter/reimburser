require 'rails_helper'

RSpec.describe ProjectSet, type: :model do
  describe 'projects' do
    let(:project_1) { Project.new() }
    let(:project_2) { Project.new() }
    let(:project_set) { ProjectSet.new(project_1, project_2) }

    it { expect(project_set.projects.count).to eq(2) }
  end

  describe 'instanct tests' do
    let(:project_1) { Project.new(
        city_value: :low,
        starts_at: DateTime.parse('2015-09-01'),
        ends_at: DateTime.parse('2015-09-03')
      ) }

    let(:project_2) { Project.new(
        city_value: :high,
        starts_at: DateTime.parse('2015-09-03'),
        ends_at: DateTime.parse('2015-09-05')
      ) }

    let(:set) { ProjectSet.new(project_1, project_2) }

    describe 'build_date_list' do
      it { expect(set.build_date_list).to be_a(Hash) }
      it { expect(set.build_date_list.keys.size).to eql(5) }
      it { expect(set.build_date_list.keys.first).to eql(project_1.starts_at.to_i) }
      it { expect(set.build_date_list.keys.last).to eql(project_2.ends_at.to_i) }
      it { expect(set.build_date_list[project_1.starts_at.to_i]).to eql(:low) }

      context 'when there is a collision of dates' do
        it 'correctly chooses :high over :low' do
          _date_key = DateTime.parse('2015-09-03').to_i
          expect(set.build_date_list[_date_key]).to eql(:high)
        end
      end
    end

    describe 'calculate_reimbursement' do
      it 'calculates correct reimbursement' do
        _expected_reimbursement  = 1 * Project::RATES[:travel_day_low]
        _expected_reimbursement += 1 * Project::RATES[:travel_day_high]
        _expected_reimbursement += 1 * Project::RATES[:full_day_low]
        _expected_reimbursement += 2 * Project::RATES[:full_day_high]

        expect(set.calculate_reimbursement).to eql(_expected_reimbursement)
      end
    end

    describe 'build_date_key_arrays' do
      let(:project_3) { Project.new(
          city_value: :high,
          starts_at: DateTime.parse('2015-09-07'),
          ends_at: DateTime.parse('2015-09-09')
        ) }

      let(:set_2) { ProjectSet.new(project_1, project_2, project_3) }

      it { expect(set_2.date_list.keys.count).to eql(8) }

      it 'builds two arrays, one for travel day keys and one for full' do
        expect(set_2.build_date_key_arrays(set_2.date_list.keys).flatten.size).to eql(8)
      end
    end
  end

  describe 'client specifications' do
    let(:travel_day_low) { Project::RATES[:travel_day_low] }
    let(:travel_day_high) { Project::RATES[:travel_day_high] }
    let(:full_day_low) { Project::RATES[:full_day_low] }
    let(:full_day_high) { Project::RATES[:full_day_high] }

    describe 'Set 1' do
      let(:project_1) { Project.new(
          city_value: :low,
          starts_at: DateTime.parse('2015-09-01'),
          ends_at: DateTime.parse('2015-09-03')
        ) }

      let(:set_1) { ProjectSet.new(project_1) }

      it { expect(set_1.calculate_reimbursement).to eq(project_1.reimbursement) }
    end

    describe 'Set 2' do
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

      it { expect(set_2.build_date_list.count).to eql(8) }

      context 'when calculating reimbursement' do
        it 'calculates the correct reimbursement' do
          _expected_reimbursement = (2 * travel_day_low)  +
                                    (1 * full_day_low)    +
                                    (5 * full_day_high)

          expect(set_2.calculate_reimbursement).to eql(_expected_reimbursement)
        end
      end
    end # Set 2

    describe 'Set 3' do
      let(:project_1) { Project.new(
          city_value: :low,
          starts_at: DateTime.parse('2015-09-01'),
          ends_at: DateTime.parse('2015-09-03')
        ) }

      let(:project_2) { Project.new(
          city_value: :high,
          starts_at: DateTime.parse('2015-09-05'),
          ends_at: DateTime.parse('2015-09-07')
        ) }

      let(:project_3) { Project.new(
          city_value: :high,
          starts_at: DateTime.parse('2015-09-08'),
          ends_at: DateTime.parse('2015-09-08')
        ) }

      let(:set_3) { ProjectSet.new(project_1, project_2, project_3) }

      it { expect(set_3.build_date_list.count).to eql(7) }

      context 'when calculating reimbursement' do
        it 'calculates the correct reimbursement' do
          _expected_reimbursement = (2 * travel_day_low)  +
                                    (2 * travel_day_high)  +
                                    (1 * full_day_low)    +
                                    (2 * full_day_high)

          expect(set_3.calculate_reimbursement).to eql(_expected_reimbursement)
        end
      end
    end # Set 3

    describe 'Set 4' do
      let(:project_1) { Project.new(
          city_value: :low,
          starts_at: DateTime.parse('2015-09-01'),
          ends_at: DateTime.parse('2015-09-01')
        ) }

      let(:project_2) { Project.new(
          city_value: :low,
          starts_at: DateTime.parse('2015-09-01'),
          ends_at: DateTime.parse('2015-09-01')
        ) }

      let(:project_3) { Project.new(
          city_value: :high,
          starts_at: DateTime.parse('2015-09-02'),
          ends_at: DateTime.parse('2015-09-02')
        ) }

      let(:project_4) { Project.new(
          city_value: :high,
          starts_at: DateTime.parse('2015-09-02'),
          ends_at: DateTime.parse('2015-09-03')
        ) }

      let(:set_4) { ProjectSet.new(project_1, project_2, project_3, project_4) }

      it { expect(set_4.build_date_list.count).to eql(3) }

      context 'when calculating reimbursement' do
        it 'calculates the correct reimbursement' do
          _expected_reimbursement = (1 * travel_day_low)  +
                                    (1 * travel_day_high)  +
                                    (1 * full_day_high)

          expect(set_4.calculate_reimbursement).to eql(_expected_reimbursement)
        end
      end
    end # Set 4
  end
end
