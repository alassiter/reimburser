# We will assume that inputs are given in correct types
# Dates will be datetimes and city_value will be a symbol

class Project
  attr_accessor :city_value, :starts_at, :ends_at

  CITY_VALUES = %i(high low)
  RATES = {
    travel_day_low: 45,
    travel_day_high: 55,
    full_day_low: 75,
    full_day_high: 85
  }

  def initialize(args = {})
    @city_value = args[:city_value]
    @starts_at = args[:starts_at]
    @ends_at = args[:ends_at]
  end

  def reimbursement
    case city_value
    when :low
      45*2
    when :high
      55*2
    end
  end

end
