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
  7. Exit from main menu
  8. Exit from program
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
      when 2 then train_list
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
      when 7 then break
      when 8 then exit
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
  end

  def set_route
    route = select_route
    train = select_train
    return if route.nil? || train.nil?
    train.set_route(route)
    puts "Train #{train.number} go to the route"
  end

  def hook_wagon
    train = select_train
    return if train.nil?
    if train.is_a?(CargoTrain)
      train.hook_wagon(CargoWagon.new)
    else
      train.hook_wagon(PassengerWagon.new)
    end
    puts "Wagon hook train #{train.number}"
  end

  def unhook_wagon
    train = select_train
    return if train.nil?
    train.unhook_wagon
    puts "Train consist of #{train.quantity_wagons.length} wagons"
  end

  def moving_next_station
    train = select_train
    return if train.nil?
    if train.moving_next_station
      puts "Train moved from #{train.previous_station.name} to #{train.current_station.name}"
    else
      puts "Train stayed at #{train.current_station.name}" 
    end
  end

  def moving_previouse_station
    train = select_train
    return if train.nil?
    if train.moving_previous_station
      puts "Train moved from #{train.next_station.name} to #{train.current_station.name}"
    else
      puts "Train stayed at #{train.current_station.name}"
    end
  end

  def create_route
    puts 'Start route'
    first_station = select_station
    puts 'Finish route'
    last_station = select_station
    return if first_station.nil? || last_station.nil?
    return if first_station == last_station
    @routes << Route.new(first_station, last_station)
    puts "Route #{first_station.name} to #{last_station.name} create"
  end

  def add_station
    route = select_route
    station = select_station
    return if route.nil? || station.nil?
    route.add_intermediate_station(station)
    puts "Station #{station.name} is add to route"
  end

  def del_station
    route = select_route
    return if route.nil?
    puts 'Choise station for delete: '
    route.stations.each_with_index { |station, i| puts "#{i + 1} #{station.name}" }
    i = gets.to_i
    station = route.stations[i - 1]
    route.del_intermediate_station(station)
    puts "Station #{station.name} is delete from route"
    puts 'Now route is: '
    route.stations.each { |station| puts station.name }
  end

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
end
