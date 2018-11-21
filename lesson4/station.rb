class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

#  def show_trains
#    @trains.each { |train| puts train.number }
#  end
  
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


