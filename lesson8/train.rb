require_relative 'company_name'
require_relative 'instance_counter'
require_relative 'validator'

class Train
  include CompanyName
  include InstanceCounter
  include Validator
  attr_reader :number, :type, :wagons, :speed, :route

  class << self
    def trains
      @trains = {}
    end
  end

  TEMPLATE_NUMBER = /^[a-zа-я\d]{3}[-]?[a-zа-я\d]{2}$/i.freeze
  MSG_INCORRECT_NUMBER = 'Number must be in pattern XXX-XX or XXXXX'.freeze

  def initialize(number)
    @number = number
    @type = type
    @speed = 0
    @route = nil
    @wagons = []
    @station_index = 0
    validate!
    Train.trains[number] = self
    register_instance
  end

  def self.find(number)
    Train.trains[number]
  end

  def speed_up(acceleration)
    @speed += acceleration
  end

  def speed_down(slowdown)
    if @speed > slowdown
      @speed -= slowdown
    else
      @speed = 0
    end
  end

  def hook_wagon(wagon)
    @wagons << wagon if attachable_wagon?(wagon) && @speed.zero?
  end

  def unhook_wagon
    @wagons.pop if @speed.zero? && !@wagons.empty?
  end

  def route_set(route)
    @route = route
    @station_index = 0
    @route.stations[0].take_train(self)
  end

  def moving_next_station
    return unless next_station

    current_station.send_train(self)
    next_station.take_train(self)
    @station_index += 1
  end

  def moving_previous_station
    return unless previous_station

    current_station.send_train(self)
    previous_station.take_train(self)
    @station_index -= 1
  end

  def previous_station
    return nil if @route.nil?

    @route.stations[@station_index - 1] if @station_index > 0
  end

  def current_station
    @route.stations[@station_index]
  end

  def next_station
    return nil if @route.nil?

    @route.stations[@station_index + 1]
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) }
  end

  protected

  def validate!
    raise MSG_INCORRECT_NUMBER if number !~ TEMPLATE_NUMBER
  end
end
