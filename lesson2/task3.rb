fibbonacci = [0, 1]
next_number = 1

while next_number < 100 do 
  fibbonacci << next_number
  next_number += fibbonacci[-2]
end
puts fibbonacci 
