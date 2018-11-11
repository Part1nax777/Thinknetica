arr = Array.new
x=0
y=1

while x < 100 do 
  arr << x
  arr << y
  x = x + y 
  y = y + x 
end

puts arr 
