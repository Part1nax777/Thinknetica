class CargoWagon < Wagon
  attr_reader :volume, :free_place 

  def initialize(wagon_capacity)
    super
  end

  def add_capacity(capacity)
    raise "You have so many cargo, spase: #{self.volume}" if self.volume < (free_place + capacity)
  end
end
