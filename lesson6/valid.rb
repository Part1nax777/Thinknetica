module valid
  def valid?
    validate!
    true
  rescue
    false
  end
end
