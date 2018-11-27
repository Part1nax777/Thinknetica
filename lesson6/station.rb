require_relative 'instance_counter'
require_relative 'valid'

class Station
  include InstanceCounter
  include Valid
  attr_reader :trains, :name

  @@stations = []
  TEMPLATE_NAME = /(^([\w]{3,})|([а-яА-Я0-9]{3,})$)/

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
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
    raise puts 'Name station is not correct' if name !~ TEMPLATE_NAME
  end
end
