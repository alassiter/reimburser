class ProjectSet
  attr_accessor :projects, :days_data

  def initialize(*projects)
    @projects = build_projects(projects)
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
    projects.each_with_index(1) do |project, index|
      _projects[index] = project
    end
  end

  def reimbursement

  end

  def calculate_days
    days_data[:travel_day_low] =

    # {
    #   travel_day_qty: 2,
    #   full_day_qty: build_date_list.size - 2
    # }
  end

  def build_date_list
    projects.each do |project|

    end

    projects.flat_map(&:build_days).sort
  end
end

# TODO: a set needs to take a collection of projects,
# and have its own start and end dates

[
  { id: 1, kind: :travel, value: :low, date: DateTime.parse('2018-01-03') },
  { id: 1, date: DateTime.parse('2018-01-01') },
  { id: 1, date: DateTime.parse('2018-  01-02') }
]
