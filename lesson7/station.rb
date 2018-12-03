require_relative 'instance_counter'
require_relative 'validator'

class Station
  include InstanceCounter
  include Validator
  attr_reader :trains, :name

  class << self
    def stations
      @stations = []
    end
  end

  TEMPLATE_NAME = /^[а-яёa-z\d]{3,}$/i.freeze
  MSG_INCORRECT_NAME = 'Name station is not correct'.freeze

  def initialize(name)
    @name = name
    @trains = []
    validate!
    Station.stations << self
    register_instance
  end

  def self.all
    Station.stations
  end

  def take_train(train)
    @trains << train
  end

  def train_type_list(type_train)
    @trains.select { |_type| train.type == type_train }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  protected

  def validate!
    raise MSG_INCORRECT_NAME if name !~ TEMPLATE_NAME
  end
end
