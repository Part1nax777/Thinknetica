class PassengerTrain < Train
  attr_reader :type
  attr_accessor_with_history :route

  validate :number, :presence
  validate :number, :format, TEMPLATE_NUMBER
  validate :number, :type, String

  def initialize(number)
    super
    @type = :passenger
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(PassengerWagon)
  end
end
