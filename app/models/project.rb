# We will assume that inputs are given in correct types
# Dates will be datetimes and city_value will be a symbol

class Project
  attr_accessor :city_value, :starts_at, :ends_at

  CITY_VALUES = { low: 0, high: 1 }

  RATES = {
    travel_day_low: 45,
    travel_day_high: 55,
    full_day_low: 75,
    full_day_high: 85
  }

  def initialize(args = {})
    @city_value = args[:city_value]
    @starts_at = args[:starts_at] || args[:ends_at]
    @ends_at = args[:ends_at] || args[:starts_at]
  end

  def reimbursement(travel_day_qty: 2, full_day_qty: nil)
    travel_day_reimbursement(travel_day_qty) +
    full_day_reimbursement(full_day_qty)
  end

  def build_days
    return [] if starts_at.nil? || ends_at.nil?

    (starts_at..ends_at).to_a.map(&:to_i)
  end

  def calculate_total_days
    return [] if starts_at.nil? || ends_at.nil?

    (starts_at..ends_at).uniq.count
  end

  def calculate_full_day_qty
    days = (starts_at..ends_at).count
    return 0 if days <= 2

    days - 2
  end

  private
  def travel_day_reimbursement(travel_day_qty)
    # This exercise assumes always a start and end date
    travel_day_qty * RATES["travel_day_#{city_value}".to_sym]
  end

  def full_day_reimbursement(full_day_qty)
    (full_day_qty || calculate_full_day_qty) * RATES["full_day_#{city_value}".to_sym]
  end

  def set_default_dates

  end
end
