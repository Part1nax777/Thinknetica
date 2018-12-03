require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'

class Main
  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  MAIN_MENU = <<-MENU.freeze
  Main Menu
  Select menu item
  1. Stations
  2. Trains
  3. Routes
  0. Exit from program
  MENU

  STATION_MENU = <<-MENU.freeze
  Menu Station
  1. Create station
  2. Train list at the station
  3. Show station list
  4. Enter main menu
  MENU

  TRAINS_MENU = <<-MENU.freeze
  Menu Trains
  1. Create train
  2. Set route
  3. Hook wagon
  4. Unhook wagon
  5. Moving next station
  6. Moving previouse station
  7. Show wagons stat
  8. Load wagon
  9. Exit from main menu
  MENU

  ROUTES_MENU = <<-MENU.freeze
  Menu routes
  1. Create route
  2. Add station to route
  3. Delete station from route
  4. Enter main menu
  MENU

  CHANGE_TYPE_TRAIN = <<-MENU.freeze
  Enter train type:
  1. Cargo
  2. Passenger
  MENU

  CHOISE_MAIN_MENU = { 1 => :station_menu,
                       2 => :trains_menu,
                       3 => :routes_menu }.freeze

  CHOISE_STATION_MENU = { 1 => :create_station,
                          2 => :show_trains,
                          3 => :station_list }.freeze

  CHOISE_TRAINS_MENU = { 1 => :create_train,
                         2 => :set_route,
                         3 => :hook_wagon,
                         4 => :unhook_wagon,
                         5 => :moving_next_station,
                         6 => :moving_previouse_station,
                         7 => :show_wagons,
                         8 => :load_wagon }.freeze

  CHOISE_ROUTES_MENU = { 1 => :create_route,
                         2 => :add_station,
                         3 => :del_station }.freeze

  def start
    main_menu
  end

  private

  # this methods used in other methods.

  def main_menu
    loop do
      puts MAIN_MENU
      menu_item = gets.to_i
      send CHOISE_MAIN_MENU[menu_item] || exit
    end
  end

  def station_menu
    loop do
      puts STATION_MENU
      menu_item = gets.to_i
      send CHOISE_STATION_MENU[menu_item] || break
    end
  end

  def trains_menu
    loop do
      puts TRAINS_MENU
      menu_item = gets.to_i
      send CHOISE_TRAINS_MENU[menu_item] || break
    end
  end

  def routes_menu
    loop do
      puts ROUTES_MENU
      menu_item = gets.to_i
      send CHOISE_ROUTES_MENU[menu_item] || break
    end
  end

  def create_station
    puts 'Enter station name: '
    name = gets.chomp
    @stations << Station.new(name)
  rescue RuntimeError => e
    puts "Error: #{e.message}"
    retry
  end

  def station_list
    @stations.each { |station| puts station.name }
  end

  def create_train
    puts 'Enter train number: '
    number = gets.chomp
    puts CHANGE_TYPE_TRAIN
    type = gets.to_i
    @trains << CargoTrain.new(number) if type == 1
    @trains << PassengerTrain.new(number) if type == 2
  rescue RuntimeError => e
    puts "Error: #{e.message}"
    retry
  end

  def set_route
    route = select_route
    train = select_train
    return if route.nil? || train.nil?

    train.route_set(route)
  end

  def hook_wagon
    train = select_train
    return if train.nil?

    train.is_a?(CargoTrain) ? hook_cargo_wagon(train) : hook_passenger_wagon(train)
  end

  def hook_cargo_wagon(train)
    puts 'Enter cargo volume: '
    wagon_capacity = gets.to_i
    train.hook_wagon(CargoWagon.new(wagon_capacity))
  end

  def hook_passenger_wagon(train)
    puts 'Enter number of seats: '
    total_places = gets.to_i
    train.hook_wagon(PassengerWagon.new(total_places))
  end

  def show_wagons
    train = select_train
    train.each_wagon do |wagon|
      if wagon.class == CargoWagon
        puts "#{wagon.class}. Free space: #{wagon.free_capacity}, occuped: #{wagon.filled_capacity}"
      else
        puts "#{wagon.class}. Free seats: #{wagon.free_capacity}, taken: #{wagon.filled_capacity}"
      end
    end
  end

  def show_trains
    @stations.each do |station|
      puts "In station #{station.name}: "
      station.each_train do |train|
        puts "Train: #{train.number}. Type: #{train.type}, Waggons: #{train.wagons.length}"
      end
    end
  end

  def load_wagon
    train = select_train
    wagon = select_train_wagon(train)
    train.is_a?(CargoTrain) ? load_cargo_wagon(wagon) : load_passenger_wagon(wagon)
  rescue RuntimeError => e
    puts "Error: #{e.message}"
    retry if train.is_a?(CargoTrain)
  end

  def select_train_wagon(train)
    puts 'Enter number of wagon: '
    train.wagons.each_with_index do |wagon, index|
      puts "#{index + 1}. #{wagon.class}"
    end
    wagon_index = gets.to_i
    train.wagons[wagon_index - 1]
  end

  def load_cargo_wagon(wagon)
    puts 'Enter volume to load: '
    volume = gets.to_i
    wagon.add_capacity(volume)
  end

  def load_passenger_wagon(wagon)
    wagon.add_capacity
    puts 'You occuped place in passenger_wagon'
  end

  def unhook_wagon
    train = select_train
    return if train.nil?

    train.unhook_wagon
  end

  def moving_next_station
    train = select_train
    return if train.nil?

    train.moving_next_station
  end

  def moving_previouse_station
    train = select_train
    return if train.nil?

    train.moving_previous_station
  end

  def create_route
    puts 'Start route'
    first_station = select_station(@stations)
    puts 'Finish route'
    last_station = select_station(@stations)
    return if first_station.nil? || last_station.nil?

    @routes << Route.new(first_station, last_station)
  rescue RuntimeError => e
    puts "Error: #{e.message}"
    retry
  end

  def add_station
    route = select_route
    station = select_station(@stations)
    return if route.nil? || station.nil?

    route.add_intermediate_station(station)
  end

  def del_station
    route = select_route
    return if route.nil?

    station = select_station(route.stations)
    route.del_intermediate_station(station)
  end

  def select_station(stations)
    @stations.each_with_index { |station, i| puts "#{i + 1}. #{station.name}" }
    puts 'Enter number station: '
    number = gets.to_i
    stations[number - 1]
  end

  def select_route
    @routes.each_with_index do |route, i|
      puts "#{i + 1}. #{route.stations[0].name} to #{route.stations[-1].name}"
    end
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
end
