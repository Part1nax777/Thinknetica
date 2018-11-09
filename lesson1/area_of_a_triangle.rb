class AreaCalculator
  def self.triangle(base, height)
    base * height / 2.0
  end
end

puts 'Enter base (a) triangle: '
base = gets.to_f
puts 'Enter height (h) triangle: '
height = gets.to_f

triangle_area = AreaCalculator.triangle(base, height)
puts "The area of triangle = #{triangle_area}"
