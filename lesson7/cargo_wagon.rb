class CargoWagon < Wagon
  attr_reader :wagon_capacity, :cargo

  def initialize(wagon_capacity)
    @wagon_capacity = wagon_capacity
    @cargo = 0
  end

  def cargo_capacity(cargo)
    @cargo ||= 0
    if @cargo <= @wagon_capacity
      @cargo += cargo
    end
  end

  def all_cargo_capacity
    @cargo
  end

  def free_wagon_capacity 
    @wagon_capacity - @cargo
  end
end
