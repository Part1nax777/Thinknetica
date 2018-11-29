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
  MENU

  STATION_MENU = <<-MENU.freeze
  Menu Station
  1. Create station
  2. Train list at the station
  3. Show station list
  4. Enter main menu
  5. Exit from program
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
  8. Exit from main menu
  9. Exit from program
  MENU

  ROUTES_MENU = <<-MENU.freeze
  Menu routes
  1. Create route
  2. Add station to route
  3. Delete station from route
  4. Enter main menu
  5. Exit from program
  MENU

  CHANGE_TYPE_TRAIN = <<-MENU.freeze
  Enter train type:
  1. Cargo
  2. Passenger
  MENU

  def start
    main_menu
  end

  private
  #используются в других методах изменение может отразится на работе программы
  def main_menu
    loop do
      puts MAIN_MENU
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
      puts STATION_MENU
      station_choise = gets.to_i
      case station_choise
      when 1 then create_station
      when 2 then show_trains
      when 3 then station_list
      when 4 then break
      when 5 then exit
      end
    end
  end

  def trains_menu
    loop do
      puts TRAINS_MENU
      train_choise = gets.to_i
      case train_choise
      when 1 then create_train
      when 2 then set_route
      when 3 then hook_wagon
      when 4 then unhook_wagon
      when 5 then moving_next_station
      when 6 then moving_previouse_station
      when 7 then show_wagons
      when 8 then break
      when 9 then exit
      end
    end
  end

  def routes_menu
    loop do
      puts ROUTES_MENU
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

  def create_station
    puts 'Enter station name: '
    name = gets.chomp
    @stations << Station.new(name)
  rescue RuntimeError => e
    puts "Error: #{e.message}"
    retry
  end

  def create_train
    puts 'Enter train number: '
    number = gets.chomp
    puts CHANGE_TYPE_TRAIN
    type = gets.to_i
    case type
    when 1
      @trains << CargoTrain.new(number)
      puts "Cargo train #{number} is create"
    when 2
      @trains << PassengerTrain.new(number)
      puts "Passenger train #{number} is create"
    end
  rescue RuntimeError => e
    puts "Error: #{e.message}"
    retry
  end

  def set_route
    route = select_route
    train = select_train
    return if route.nil? || train.nil?
    train.set_route(route)
  end

  def hook_wagon
    train = select_train
    return if train.nil?
    if train.is_a?(CargoTrain)
      puts 'Enter cargo volume: '
      wagon_capacity = gets.to_i
      train.hook_wagon(CargoWagon.new(wagon_capacity))
    else
      puts 'Enter number of seats: '
      total_places = gets.to_i
      train.hook_wagon(PassengerWagon.new(total_places))
    end
  end

  def show_wagons
    train = select_train
    train.wagon_in_block do |wagon|
      if wagon.class == CargoWagon
        puts "#{wagon.class}. Free space: #{wagon.free_wagon_capacity}, occupied space: #{wagon.all_cargo_capacity}"
      else
        puts "#{wagon.class}. Free seats: #{wagon.quantity_free_places}, taken seats: #{wagon.quantity_occupied_places}"
      end
    end
  end

  def show_trains
      @stations.each do |station|
        puts "In station #{station.name}: "
        station.train_in_block do |train|
          puts "Train: #{train.number}. Type: #{train.type}, Waggons: #{train.quantity_wagons.length}"
        end
      end
  end

  def load_wagon
    train = select_train
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
    puts "#{e.message}"
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
end
