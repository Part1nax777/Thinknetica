class CargoTrain < Train
  attr_reader :type

  validate :number, :presence
  validate :number, :format, TEMPLATE_NUMBER
  validate :number, :type, String

  def initialize(number)
    super
    @type = :cargo
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(CargoWagon)
  end
end
