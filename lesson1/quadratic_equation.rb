class SquareEduation
  def initialize(a, b, c)
    @a, @b, @c = a, b, c
  end

  def show_solution 
    d = @b**2 - 4 * @a * @c
    if d > 0
      sqr_d = Math.sqrt(d) 
      x1 = (-@b + sqr_d) / (2.0 * @a) 
      x2 = (-@b - sqr_d) / (2.0 * @a)
      puts "Discr = #{d}, x1 = #{x1}, x2 = #{x2}"
    elsif d == 0
      x = -@b / (2.0 * @a)
      puts "Discr = #{d}, x = #{x}"
    else
      puts "Discr = #{d}, no solution"
    end
  end
end

puts 'Enter values a, b, c for equation: '
a = gets.to_f
b = gets.to_f
c = gets.to_f
    
enter = SquareEduation.new(a, b, c)
enter.show_solution
