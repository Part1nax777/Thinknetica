require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :trains, :name

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
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
end
