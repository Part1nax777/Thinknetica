require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations
  FIRST_AND_LAST_EQL = 'First station equals last_station'.freeze
  FIRST_AND_LAST_NOT_STATIONS = 'Not correct class for first or last stations'.freeze

  validate :first_station, :type, Station
  validate :last_station, :type, Station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    validate!
    @stations = [first_station, last_station]
  end

  def add_intermediate_station(station)
    @stations.insert(-2, station)
  end

  def del_intermediate_station(station)
    return if [@stations.first, @station.last].include(station)

    @stations.delete(station)
  end

  def output_stations
    @stations.each { |station| puts station.name }
  end
end
