require_relative 'company_name'
require_relative 'instance_counter'
require_relative 'validator'

class Train
  include CompanyName
  include InstanceCounter
  include Validator
  attr_reader :number, :type, :quantity_wagons, :speed, :route

  @@trains = {}
  TEMPLATE_NUMBER = /^[a-zа-я\d]{3}[-]?[a-zа-я\d]{2}$/i
  MSG_INCORRECT_NUMBER = 'Number must be in pattern XXX-XX or XXXXX'

  def initialize(number)
    @number = number
    @type = type
    @speed = 0
    @route = nil
    @quantity_wagons = []
    @station_index = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
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
    if attachable_wagon?(wagon) && @speed == 0
      @quantity_wagons << wagon
    end
  end

  def unhook_wagon
    if @speed == 0 && @quantity_wagons.length > 0
      @quantity_wagons.pop
    end
  end

  def set_route(route)
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
    return nil if @route == nil
    @route.stations[@station_index - 1] if @station_index > 0
  end

  def current_station
    @route.stations[@station_index]
  end

  def next_station
    return nil if @route == nil
    @route.stations[@station_index + 1]
  end

  def each_wagon
    @quantity_wagons.each { |wagon| yield(wagon) }
  end

  protected

  def validate!
    raise MSG_INCORRECT_NUMBER if number !~ TEMPLATE_NUMBER
  end
end
