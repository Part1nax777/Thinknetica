shopping_cart = {}

loop do
  puts 'Enter product name (enter stop for complete): '
  product = gets.chomp
  break if product == 'stop'
  puts 'Enter price: '
  price = gets.to_f
  puts 'Enter quantity: '
  quantity = gets.to_f
  shopping_cart[product] = { price: price, quantity: quantity }
end

puts shopping_cart

total = 0
shopping_cart.each do |product, info|
  price = info[:price]
  quantity = info[:quantity]
  sum = price * quantity
  total += sum
  puts "Product: #{product}, price: #{price}, quantity: #{quantity}, summary: #{sum}"
end

puts "Total amount of your purchase = #{total}"
