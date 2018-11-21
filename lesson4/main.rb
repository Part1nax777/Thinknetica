require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'

@stations = []
@routes = []
@trains = []

def main_menu
  loop do
    puts 'Main Menu'
    puts 'Select menu item'
    puts '1. Stations'
    puts '2. Trains'
    puts '3. Routes'
    choise = gets.to_i
    case choise
    when 1 then station_menu
    when 2 then trains_menu
    when 3 then routes_menu
    when 4 then exit
    end
  end
end

def station_menu
  loop do
    puts '1. Create station'
    puts '2. Train list at the station'
    puts '3. Show station list'
    puts '4. Enter main menu'
    puts '5. Exit from program'
    station_choise = gets.to_i
    case station_choise
    when 1 then create_station
    when 2 then train_list
    when 3 then station_list
    when 4 then break
    when 5 then exit
    end
  end
end

def create_station
  puts 'Enter station name: '
  name = gets.chomp
  @stations << Station.new(name)
  puts "Station #{name} is create"
end

def train_list
  @stations.each do |station|
    puts "In station #{station.name} stoped trains: "
    station.trains.each do |train|
    puts "#{train.number}"
    end
  end
end

def station_list
  @stations.each { |station| puts station.name }
end

def trains_menu
  loop do
    puts '1. Create train'
    puts '2. Set route'
    puts '3. Hook wagon'
    puts '4. Unhook wagon'
    puts '5. Moving next station'
    puts '6. Moving previouse station'
    puts '7. Exit from main menu'
    puts '8. Exit from program'
    train_choise = gets.to_i
    case train_choise
    when 1 then create_train
    when 2 then set_route
    when 3 then hook_wagon
    when 4 then unhook_wagon
    when 5 then moving_next_station
    when 6 then moving_previouse_station
    when 7 then break
    when 8 then exit
    end
  end
end

def create_train
  puts 'Enter train number: '
  number = gets.chomp
  puts 'Enter train type:
  1. Cargo
  2. Passenger'
  type = gets.to_i
    case type
    when 1
      @trains << CargoTrain.new(number)
      puts "Cargo train #{number} is create"
    when 2
      @trains << PassengerTrain.new(number)
      puts "Passenger train #{number} is create"
    end
  end

def set_route
  route = select_route
  train = select_train
  train.set_route(route)
  puts "Train #{train.number} go to the route"
end

def hook_wagon
  train = select_train
  train.is_a?(CargoTrain)
  train.hook_wagon(CargoWagon.new)
  train.is_a?(PassengerTrain)
  train.hook_wagon(PassengerWagon.new)
  puts "Wagon hook to #{train.type} train #{train.number}"
end

def unhook_wagon
  train = select_train
  train.unhook_wagon
  puts "Train consist of #{train.quantity_wagons.length} wagons"
end

def moving_next_station
  train = select_train
  current_station_start = train.current_station
  train.moving_next_station
  current_station_finish = train.current_station
  puts "Train moved from #{current_station_start.name} to #{current_station_finish.name}"
  puts "Train stopeed in #{train.current_station.name}"
end

def moving_previouse_station
  train = select_train
  current_station_start = train.current_station
  train.moving_previous_station
  current_station_finish = train.current_station
  puts "Train moved from #{current_station_start.name} to #{current_station_finish.name}"
  puts "Train stopeed in #{train.current_station.name}"
end

def routes_menu
  loop do
    puts '1. Create route'
    puts '2. Add station to route'
    puts '3. Delete station from route'
    puts '4. Enter main menu'
    puts '5. Exit from program'
    route_choise = gets.to_i
    case route_choise
    when 1 then create_route
    when 2 then add_station
    when 3 then del_station
    when 4 then break
    when 5 then exit
    end
  end
end

def create_route
  puts 'Start route'
  first_station = select_station
  puts 'Finish route'
  last_station = select_station
  @routes << Route.new(first_station, last_station)
  puts "Route #{first_station.name} to #{last_station.name} create"
end

def add_station
  route = select_route
  station = select_station
  route.add_intermediate_station(station)
  puts "Station #{station.name} is add to route"
end

def del_station
  route = select_route
  puts 'Train go to the route: '
  route.stations.each { |station| puts station.name }
  station = select_station
  route.del_intermediate_station(station)
  puts "Station #{station.name} is delete from route"
  puts 'Now route is: '
  route.stations.each { |station| puts station.name }
end

#private
# данные методы не используются на прямую, и являются ключевыми для работы других методов.
def select_station
  @stations.each_with_index { |station, i| puts "#{i + 1}. #{station.name}" }
  puts 'Enter number station: '
  number = gets.to_i
  @stations[number - 1]
end

def select_route
  @routes.each_with_index { |route, i| puts "#{i + 1}. #{route.stations[0].name} to #{route.stations[-1].name}" }
  puts 'Enter number of route: '
  number = gets.to_i
  @routes[number - 1]
end

def select_train
  @trains.each_with_index { |train, i| puts "#{i + 1}. #{train.number}" }
  puts 'Enter number of train: '
  number = gets.to_i
  @trains[number - 1]
end

main_menu
