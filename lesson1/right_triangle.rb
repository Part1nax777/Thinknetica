class Triangle
  def initialize(a, b, c)
    @cathetus1, @cathetus2, @hypotenuse = [a, b, c].sort
  end

  def type
    rectangular = @hypotenuse**2 == @cathetus1**2 + @cathetus2**2
    isosceles = @cathetus1 == @cathetus2
    equilateral = @cathetus1 == @cathetus2 && @cathetus2 == @hypotenuse
    invalid = @cathetus1 + @cathetus2 <= @hypotenuse

    if invalid 
      puts 'This is not triangle'
    elsif isosceles && rectangular 
      puts 'Triangle is rectangular & isosceles' 
    elsif rectangular        
      puts 'Triangle is rectangular' 
    else
      puts 'Triangle is equilateral & isosceles but not rectangular'
    end
  end
end

puts 'Enter three sides of triangle: '
a = gets.to_f
b = gets.to_f
c = gets.to_f

triangle1 = Triangle.new(a, b, c)
triangle1.type
