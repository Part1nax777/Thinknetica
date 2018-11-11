months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts 'Enter day: '
day = gets.to_i
puts 'Enter month: '
month = gets.to_i
puts 'Enter year: '
year = gets.to_i

year_100 = year % 100 != 0 # не високосный
year_400 = year % 400 == 0 # високосный
year_4 = year % 4 == 0     # високосный

months[1] = 29 if (year_4) && (year_400 || year_100)

days = months.take(month - 1).sum + day
puts "This is #{days} day in year"

