class ProjectSet
  attr_accessor :projects, :date_list

  def initialize(*projects)
    @projects = build_projects(projects)
    @date_list = {}

    build_date_list
  end

  def build_projects(projects)
    _projects = {}
    projects.each.with_index(1) do |project, index|
      _projects[index] = project
    end

    _projects
  end

  def build_date_list
    projects.values.each do |project|
      _days_list = project.build_days

      _days_list.each do |date|
        add_date_to_date_list(date, project.city_value)
      end
    end

    date_list
  end

  def calculate_reimbursement
    travel_days = date_list.extract!(date_list.keys.first, date_list.keys.last)
    full_days = date_list
    travel_days.update(travel_days) { |date, value| Project::RATES["travel_day_#{value}".to_sym] }
    full_days.update(full_days) { |date, value| Project::RATES["full_day_#{value}".to_sym] }

    total = travel_days.values.sum + full_days.values.sum
  end

  private
  def add_date_to_date_list(date, value)
    if date_list.key?(date)
      date_list[date] = Project::CITY_VALUES[value] > Project::CITY_VALUES[date_list[date]] ? value : date_list[date]
    else
      date_list[date] = value
    end
  end
end

# 1. take all projects
# 2. explode date range into dates
# 3. Classify each date as either high or low
# 4. Pull out duplicate dates
# 5. assign first and last date as travel
# 6. assign all other dates as full days
# 7. calculate each date reimbursement
# 8. Total the individual days
