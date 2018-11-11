vowels = %w[a e i o u]   
alphabet = ('a'..'z').to_a
vowels_hash = {}

alphabet.each_with_index do |item, index|
  vowels_hash[item] = index + 1 if vowels.include?(item)
end
puts vowels_hash 


