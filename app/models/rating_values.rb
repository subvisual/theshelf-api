module RatingValues
  SCALE = (1..5).to_a.freeze
  private_constant :SCALE

  def self.all
    SCALE
  end

  def self.highest
    SCALE.last
  end

  def self.valid?(value)
    SCALE.include? value
  end
end
