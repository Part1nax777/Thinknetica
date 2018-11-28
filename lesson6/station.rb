require_relative 'instance_counter'
require_relative 'validator'

class Station
  include InstanceCounter
  include Valid
  attr_reader :trains, :name

  @@stations = []
  TEMPLATE_NAME = /^[а-яёa-z\d]{3,}$/i
  MSG_INCORRECT_NAME = 'Name station is not correct'

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def take_train(train)
    @trains << train
  end

  def train_type_list(type_train)
    @trains.select { |type| train.type == type_train }
  end

  def send_train(train)
    @trains.delete(train)
  end

  protected

  def validate!
    raise MSG_INCORRECT_NAME if name !~ TEMPLATE_NAME
  end
end
