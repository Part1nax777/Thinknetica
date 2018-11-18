class Train
  attr_reader :number, :type, :quantity_wagons, :speed, :route

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @route = nil
    @quantity_wagons = []
    @station_index = 0
  end
  #набор скорости, по умолчанию поезд стоит
  def speed_up(acceleration)
    @speed += acceleration
  end
  #текущая скорость
  def current_speed
    @speed 
  end
  #поезд тормозит
  def speed_down(slowdown)
    if @speed > slowdown
      @speed -= slowdown
    else
      @speed = 0
    end
  end
  #прицеплять вагон
  def hook_wagon(wagon)
    @quantity_wagons << wagon if @speed == 0
  end
  #отцеплять вагон
  def unhook_wagon
    @quantity_wagons -=1 if @speed == 0 && @quantity_wagons > 0 
  end
  #маршрут следования (маршрут из класса route)
  def set_route(route)
    @route = route
    @station_index = 0
    #устанавливает в начальную точку поезд из списка поездов на станции  
    @route.stations[0].take_train(self) 
  end
  #перемещение между станциями(на одну станцию за раз)
  def moving_next_station
    return unless next_station 
    current_station.send_train(self) 
    next_station.take_train(self)
    @station_index += 1
  end

  def moving_previous_station
    return unless previous_station
    current_station.send_train(self)  
    previous_station.take_train(self)
    @station_index -= 1
  end 
  #предыдущая, текущая, следующая станция
  def previous_station
    return nil if @route == nil
    @route.stations[@station_index - 1] if @station_index > 0
  end

  def current_station
    @route.stations[@station_index]
  end

  def next_station
    return nil if @route == nil
    @route.stations[@station_index + 1]
  end
end
