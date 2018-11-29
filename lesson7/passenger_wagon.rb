class PassengerWagon < Wagon
  attr_accessor :total_places, :occupied_places 

  def initialize(total_places)
    @total_places = total_places
    @occupied_places = 0
  end

  def add_occupied_place
    @occupied_places ||= 0
    @occupied_places += 1 if @occured_places < @total_places
  end

  def quantity_occupied_places
    @occupied_places
  end

  def quantity_free_places
    @total_places - @occupied_places
  end
end
