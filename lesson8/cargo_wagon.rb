class CargoWagon < Wagon
  def initialize(wagon_capacity)
    super
  end

  def add_capacity(capacity)
    @overload_error = "You have so many cargo, spase: free space: #{free_capacity}"
    super
  end
end
