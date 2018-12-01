class PassengerWagon < Wagon
  attr_reader :volume, :free_place 

  def initialize(total_places)
    super
  end

  def add_capacity(capacity = 1) 
    raise 'Wagon full!' if self.volume < (free_place + capacity)
    super
  end
end
