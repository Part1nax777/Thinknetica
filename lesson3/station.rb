class Station
  
  initialize(station_name)
    @station_name = station_name.capitalize
  end

  #принимать поезда один за раз
  def take_train
  end

  #список поездов на станции в данный момент
  def train_list
  end

  #список поездов на станции по типу
  def train_type_list
  end

  #отправлять поезда (по одному за раз, удаляется из списка поездов находящихся на станции)
  def send_train
  end
end
