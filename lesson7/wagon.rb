require_relative 'company_name'

class Wagon
  include CompanyName

  def initialize(volume) 
    @volume = volume
    @free_place = 0
  end

  def add_capacity(capacity)
    @free_place += capacity
    @volume -= capacity
  end
end
