#подключаем классы
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'passengerwagon'
require_relative 'cargowagon'
require_relative 'passengertrain'
require_relative 'cargotrain'

#создание главного меню
def main_menu
  loop do 
    puts 'Main Menu'
    puts 'Select menu item'
    puts '1. Stations'
    puts '2. Trains'
    puts '3. Routes'
    choise = gets.to_i

    case choise 
    when 1
      station_menu 
    when 2
      trains_menu
    when 3
      routes_menu
    end
  end
end


#меню станции
def station_menu
  loop do 
    puts '1. Create station'
    puts '2. Train list at the station'
    puts '3. Enter main menu'
    puts '4. Exit from program'
    station_choise = gets.to_i

    case station_choise
    when 1
      create_station
    when 2
      train_list
    when 3
      break
    when 4
      exit
    end
  end
end

#меню поезда
def trains_menu
  loop do
    puts '1. Set route'
    puts '2. Hook wagon'
    puts '3. Unhook wagon'
    puts '4. Moving next station'
    puts '5. Moving previouse station'
    puts '6. Exit from main menu'
    puts '7. Exit from program'
    train_choise = gets.to_i

    case train_choise
    when 1
      set_route
    when 2
      hook_wagon
    when 3
      unhook_wagon
    when 4
      moving_next_station
    when 5
      moving_previouse_station
    when 6
      break
    when 7 
      exit 
    end
  end
end

#меню маршрут
def routes_menu
  loop do 
    puts '1. Create route'
    puts '2. Add station to route'
    puts '3. Delete station from route'
    puts '4. Enter main menu'
    puts '5. Exit from program'
    route_choise = gets.to_i

    case route_choise
    when 1
      create_route
    when 2
      add_station
    when 3
      delete_station
    when 4
      break
    when 5
      exit
    end
  end
end

main_menu
