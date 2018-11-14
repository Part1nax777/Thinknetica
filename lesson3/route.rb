class Route
  attr_reader :route_stations

  def initialize(first_station, last_station)
    @route_stations = [first_station, last_station]
  end

  #добавление промежуточной станции
  def add_intermediate_station(station)
    @route_stations.insert(-2, station)
  end

  #удаление промежуточной станции
  def del_intermediate_station(station)
    @route_stations.delete(station)
  end

  #вывод всех станций по порядку от начальной до конечной
  def output_stations
    @route_stations.each { |station| puts station }
  end
end
