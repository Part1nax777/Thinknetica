class CargoWagon < Wagon
  attr_reader :wagon_capacity, :cargo

  def initialize(wagon_capacity)
    @wagon_capacity = wagon_capacity
    
  end

  def cargo_capacity(cargo)
    @cargo = cargo 
    @wagon_capacity -= cargo
  end

  def all_cargo_capacity
    @cargo
  end

  def free_wagon_capacity 
    @wagon_capacity - @cargo
  end
end
