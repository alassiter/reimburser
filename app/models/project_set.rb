class ProjectSet
  attr_accessor :projects, :date_list, :days_data

  def initialize(*projects)
    @projects = build_projects(projects)
    @date_list = {}
    @days_data = {
      travel_day_low: { count: 0, dates: [] },
      travel_day_high: { count: 0, dates: [] },
      work_days_low: { count: 0, dates: [] },
      work_days_high: { count: 0, dates: [] }
    }
  end

  def build_projects(projects)
    # { 1: <Project #>, 2: <Project #> }
    _projects = {}
    projects.each.with_index(1) do |project, index|
      _projects[index] = project
    end

    _projects
  end

  def build_date_list
    projects.each do |project|
      _days_list = project.build_days

      _days_list.each do |date|
        add_date_to_date_list(date, project.city_value)
      end
    end
  end

  def reimbursement

  end

  private
  def add_date_to_date_list(date, value)
    # check for day
    # do something
    if date_list.key?(date)
      date_list[date] = Project::CITY_VALUES[value] > # START HERE, need to compare values, then set a value if higher
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
