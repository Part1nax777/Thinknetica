class Train

  def initialize(train_number, train_type, quantity_wagons)
    @train_number = train_number
    @train_type = train_type
    @quantity_wagons = quantity_wagons
  end

  #набор скорости
  def speed_up
  end

  #текущая скорость
  def current_speed
  end

  #тормозить
  def speed_down
  end

  #количество вагонов
  def quantity_wagons
  end

  #прицеплять/отцеплять вагоны
  def hook_unhook_wagons
  end

  #маршрут следования
  def train_route
  end

  #перемещение между станциями(на одну станцию за раз)
  def moving_between_stations
  end

  #предыдущая, текущая, следующая станция
  def station_advertisement
  end
end
