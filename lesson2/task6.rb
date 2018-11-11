shop_basket = {}

loop do
  puts "Enter product name (enter 'stop' for complete): "
  product = gets.chomp
  break if product == 'stop'
  puts "Enter price: "
  price = gets.to_f
  puts "Enter quantity: "
  quantity = gets.to_f
  shop_basket[product] = {price: price, quantity: quantity}
end

puts shop_basket

all_sum = 0
shop_basket.each do |key, value|
  price = value[:price]
  quantity = value[:quantity]
  sum = price * quantity
  all_sum += sum
  puts "Product: #{key}, price: #{price}, quantity: #{quantity}, summary: #{sum}"
end

puts "Total amount of your purchase = #{all_sum}"
