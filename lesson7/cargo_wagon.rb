class CargoWagon < Wagon
  attr_reader :wagon_capacity, :cargo

  def initialize(wagon_capacity)
    @wagon_capacity = wagon_capacity
    @cargo = 0
  end

  def cargo_capacity(cargo)
    raise "You have so many cargo, spase: #{self.wagon_capacity}" if cargo > self.wagon_capacity
    @cargo = cargo
    @wagon_capacity -= cargo
  end
end
