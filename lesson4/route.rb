class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end
  #добавление промежуточной станции
  def add_intermediate_station(station)
    @stations.insert(-2, station)
  end
  #удаление промежуточной станции
  def del_intermediate_station(station)
    @stations.delete(station)
  end
  #вывод всех станций по порядку от начальной до конечной
  def output_stations
    @stations.each { |station| puts station }
  end
end
