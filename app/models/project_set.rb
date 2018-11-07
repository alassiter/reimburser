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
        add_date_to_date_list(date, project)
      end
    end

    date_list
  end

  def calculate_reimbursement
    travel_days = date_list.extract!(date_list.keys.first, date_list.keys.last)

    travel_day_keys, full_day_keys = build_date_key_arrays(date_list.keys)

    travel_days.merge!( date_list.extract!(*travel_day_keys) )
    full_days = date_list.extract!(*full_day_keys)

    travel_days.update(travel_days) { |date, value| Project::RATES["travel_day_#{value}".to_sym] }
    full_days.update(full_days) { |date, value| Project::RATES["full_day_#{value}".to_sym] }

    total = travel_days.values.sum + full_days.values.sum
  end

  def build_date_key_arrays(date_keys, travel_array = [], full_array = [])
    return travel_array, full_array if date_keys.empty?
    _one = date_keys[0]
    _two = date_keys[1]

    if gap_exists?(_one, _two)
      travel_array += [_one, _two]
      date_keys.delete(_one)
      date_keys.delete(_two)
      build_date_key_arrays(date_keys, travel_array, full_array)
    else
      full_array << _one
      date_keys.delete(_one)
      build_date_key_arrays(date_keys, travel_array, full_array)
    end
  end

  private
  def gap_exists?(date_one, date_two)
    return false if date_two.nil?

    one_day = 86400
    (date_two - date_one) > one_day
  end

  def add_date_to_date_list(date, project)
    if date_list.key?(date)
      date_list[date] = if Project::CITY_VALUES[project.city_value] > Project::CITY_VALUES[date_list[date]]
                          project.city_value
                        else
                          date_list[date]
                        end
    else
      date_list[date] = project.city_value
    end
  end
end
