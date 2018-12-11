require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  include InstanceCounter
  include Validation
  extend Accessors
  attr_reader :trains, :name

  class << self
    def stations
      @stations = []
    end
  end

  TEMPLATE_NAME = /^[а-яёa-z\d]{3,}$/i.freeze
  MSG_INCORRECT_NAME = 'Name station is not correct'.freeze

  validate :name, :presence
  validate :name, :format, TEMPLATE_NAME

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
    @trains.select { |train| train.type == type_train }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def each_train
    @trains.each { |train| yield(train) }
  end
end
