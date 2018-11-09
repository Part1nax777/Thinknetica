class Person
  def initialize(name, growth)
    @name = name
    @ideal_weight = growth - 110
  end
  
  def show_weight_info
    if @ideal_weight < 0 
      puts 'You weight is optimal'
    else
      puts "#{@name}, you should lose #{@ideal_weight} kilograms"
    end
  end
end

puts 'Enter you name: '
name = gets.capitalize.chomp
puts 'Enter you growth: '
growth = gets.to_i

person1 = Person.new(name, growth)
person1.show_weight_info
