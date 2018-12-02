require_relative 'company_name'

class Wagon
  include CompanyName
  attr_reader :capacity, :filled_capacity 

  def initialize(capacity)
    @capacity = capacity
    @filled_capacity = 0
  end

  def free_capacity
    @capacity - @filled_capacity
  end

  def add_capacity(capacity = 1)
    raise @overload_error if capacity > free_capacity
    @filled_capacity += capacity
  end
end
