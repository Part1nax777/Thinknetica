class Train
  attr_reader :train_number, :train_type, :quantity_wagons, :speed

  def initialize(train_number, train_type, quantity_wagons)
    @train_number = train_number
    @train_type = train_type
    @quantity_wagons = quantity_wagons
    @speed = 0
    @route = nil
    @station_position = 0
  end
  #набор скорости, по умолчанию поезд стоит
  def speed_up(speed=0, acceleration)
    @speed += acceleration
  end
  #текущая скорость
  def current_speed
    @speed 
  end
  #поезд тормозит
  def speed_down
    @speed = 0
  end
  #количество вагонов
  def quantity_wagons
    @quantity_wagons
  end
  #прицеплять вагон
  def hook_wagon
    @quantity_wagons += 1 if @speed == 0
  end
  #отцеплять вагон
  def unhook_wagon
    @quantity_wagons -=1 if @speed == 0
  end
  #маршрут следования (маршрут из класса route)
  def train_route(route)
    @route = route
    #устанавливает в начальную точку поезд из списка поездов на станции  
    @route.route_stations[0].take_train(self) 
  end
  #перемещение между станциями(на одну станцию за раз)
  def moving_next_stations
    current_station.send_train(self)
    @station_position += 1
    current_station.take_train(self)
  end

  def moving_previous_station
    current_station.send_train(self)
    @station_position -= 1
    current_station.take_train(self)
  end 
  #предыдущая, текущая, следующая станция
  def previous_station
    @route.route_stations[@station_position - 1] if @station_position > 0
  end

  def current_station
    @route.route_stations[@station_position]
  end

  def next_station
    @route.route_stations[@station_position + 1]
  end
end
