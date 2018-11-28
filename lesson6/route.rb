require_relative 'instance_counter'
require_relative 'validator'

class Route
  include InstanceCounter
  include Validator

  attr_reader :stations
  FIRST_AND_LAST_EQL = 'First station equals last_station'
  FIRST_AND_LAST_NOT_STATIONS = 'Not correct class for first or last stations'

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def add_intermediate_station(station)
    @stations.insert(-2, station)
  end

  def del_intermediate_station(station)
    @stations.delete(station)
  end

  def output_stations
    @stations.each { |station| puts station.name }
  end

  protected

  def validate!
    raise FIRST_AND_LAST_EQL if station_eql?
    raise FIRST_AND_LAST_NOT_STATIONS unless station_class?
  end

  def station_class?
    @stations[0].is_a?(Station) && @stations[1].is_a?(Station)
  end

  def station_eql?
    @stations[0] == @stations[1]
  end
end


