# We will assume that inputs are given in correct types
# Dates will be datetimes and city_value will be a symbol

class Project
  attr_accessor :city_value, :starts_at, :ends_at

  CITY_VALUES = %i(high low)

  def initialize(args)
    @city_value = args[:city_value]
    @starts_at = args[:starts_at]
    @ends_at = args[:ends_at]

    raise StandardError if CITY_VALUES.exclude?(@city_value)
  end



end
