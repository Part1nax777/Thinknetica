class Station
  attr_reader :trains, :station_name 

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  #принимать поезда один за раз
  def take_train(train)
    @trains << train
  end

  #список поездов на станции в данный момент
  def train_list
    @trains
  end

  #список поездов на станции по типу
  def train_type_list(train_type)
    @trains.select { |type| type.train_type == train_type}
  end

  #отправлять поезда (по одному за раз, удаляется из списка поездов находящихся на станции)
  def send_train(train)
    @trains.delete(train)
  end
end
