class PassengerWagon < Wagon

  def initialize(total_places)
    super
  end

  def add_capacity
    @overload_error = 'Wagon full!'
    super
  end
end
