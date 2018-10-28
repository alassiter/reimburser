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
    travel_day_reimbursement(city_value) +
    full_day_reimbursement(city_value)
  end

  private
  def travel_day_reimbursement(value)
    # This exercise assumes always a start and end date
    2 * RATES["travel_day_#{value}".to_sym]
  end

  def full_day_reimbursement(value)
    full_day_qty * RATES["full_day_#{value}".to_sym]
  end

  def full_day_qty
    days = (starts_at..ends_at).count
    return 0 if days <= 2
    
    days - 2
  end
end
