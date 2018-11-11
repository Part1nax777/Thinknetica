months = {1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 
          6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31,
          11 => 30, 12 => 31}

puts "Enter day: "
day = gets.to_i
puts "Enter month: "
month = gets.to_i
puts "Enter year: "
year = gets.to_i

year_100 = year%100 == 0 # не високосный
year_400 = year%400 == 0 # високосный
year_4 = year%4 == 0     # високосный

months[2] = 29 if (year_400 || year_4)

days = 0
(1...month).each do |i|
  days += months[i]
end

puts "#{days + day}"

