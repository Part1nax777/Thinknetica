class PassengerWagon < Wagon
  attr_accessor :total_places, :occupied_places

  def initialize(total_places)
    @total_places = total_places
    @occupied_places = 0
  end

  def add_occupied_place
    return 'Wagon full!' if occupied_places > self.total_places
    @occupied_places += 1
    @total_places -= 1
  end
end
