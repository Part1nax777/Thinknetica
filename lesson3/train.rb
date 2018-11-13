class Train
  attr_reader :train_number, :train_type, :quantity_wagons, :speed

  def initialize(train_number, train_type, quantity_wagons)
    @train_number = train_number
    @train_type = train_type
    @quantity_wagons = quantity_wagons
    @speed = 0
  end

  #набор скорости, по умолчанию поезд стоит
  def speed_up(speed=0, acceleration)
    @speed += acceleration
  end

  #текущая скорость
  def current_speed
    self.speed 
  end

  #поезд тормозит
  def speed_down
    self.speed = 0
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
    route.route_stations(self) #bag
  end

  #перемещение между станциями(на одну станцию за раз)
  def moving_between_stations
  end

  #предыдущая, текущая, следующая станция
  def station_advertisement
  end
end
