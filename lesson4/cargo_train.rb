class CargoTrain < Train

  def type_wagon(wagon)
    wagon.is_a?(CargoWagon)
  end
end
