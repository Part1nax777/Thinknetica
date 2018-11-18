class Station
  attr_reader :trains, :name 

  def initialize(station_name)
    @name = name
    @trains = []
  end
  #принимать поезда один за раз
  def take_train(train)
    @trains << train
  end
  #список поездов на станции по типу
  def train_type_list(type_train)
    @trains.select { |type| train.type == type_train }
  end
  #отправлять поезда (по одному за раз, удаляется из списка поездов находящихся на станции)
  def send_train(train)
    @trains.delete(train)
  end
end
