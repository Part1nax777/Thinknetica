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

  CHANGE_TYPE_TRAIN = <<-MENU.freeze
  Enter train type:
  1. Cargo
  2. Passenger
  MENU

  TEXT_MAIN = 'Main menu, make you choise: '.freeze
  TEXT_STATION = 'Stations menu, make you choise: '.freeze
  TEXT_TRAINS = 'Trains menu, make you choise: '.freeze
  TEXT_ROUTES = 'Routes menu, make you choise: '.freeze

  STATION_MENU = [
    { handler: :create_station, title: 'Create station' },
    { handler: :show_trains, title: 'Train list at the station' },
    { handler: :station_list, title: 'Show station list' },
    { handler: :show_menu, title: 'Exit main menu' }
  ].freeze

  TRAINS_MENU = [
    { handler: :create_train, title: 'Create train' },
    { handler: :set_route, title: 'Set route' },
    { handler: :hook_wagon, title: 'Hook wagon' },
    { handler: :unhook_wagon, title: 'Unhook wagon' },
    { handler: :moving_next_station, title: 'Moving next station' },
    { handler: :moving_previouse_station, title: 'Moving previouse station' },
    { handler: :show_wagons, title: 'Show wagons stat' },
    { handler: :load_wagon, title: 'Load wagon' },
    { handler: :show_menu, title: 'Exit main menu' }
  ].freeze

  ROUTES_MENU = [
    { handler: :create_route, title: 'Create route' },
    { handler: :add_station, title: 'Add station to route' },
    { handler: :del_station, title: 'Delete station from route' },
    { handler: :show_menu, title: 'Exit main menu' }
  ].freeze

  MAIN_MENU = [
    { handler: :station_menu, title: 'Stations' },
    { handler: :trains_menu, title: 'Trains' },
    { handler: :routes_menu, title: 'Routes' },
    { handler: :exit_program, title: 'Exit' }
  ].freeze

  def start
    show_menu
  end

  private

  # this methods used in other methods.

  def show_menu(title = TEXT_MAIN, menu = MAIN_MENU)
    loop do
      puts title
      show_menu_items(menu)
      selected_index = gets.to_i
      selected_item = menu[selected_index - 1] || break
      send(selected_item[:handler])
    end
  end

  def show_menu_items(menu)
    menu.each_with_index { |item, count| puts "#{count + 1}. #{item[:title]}" }
  end

  def station_menu
    show_menu(TEXT_STATION, STATION_MENU)
  end

  def trains_menu
    show_menu(TEXT_TRAINS, TRAINS_MENU)
  end

  def routes_menu
    show_menu(TEXT_ROUTES, ROUTES_MENU)
  end

  def exit_program
    puts 'Good bay, welcome you again'
    exit
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
