class Route
  def initialize(first_station, last_station)
    @route_station = [first_station, last_station]
  end

  #добавление промежуточной станции
  def add_intermediate_station
  end

  #удаление промежуточной станции
  def del_intermediate_station
  end

  #вывод всех станций по порядку от начальной до конечной
  def output_stations
  end
end
