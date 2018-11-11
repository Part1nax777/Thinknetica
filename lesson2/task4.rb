arr = %w[a e i o u] #a-97, e-101, i-105, o-111, u-117  
hh = {}
n = 0

arr.each do |i|
  hh[arr[n]] = arr[n].ord - 96 
  n += 1
end
puts hh
