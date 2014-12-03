require 'spec_helper'

describe Rating, type: :model do
  it { is_expected.to ensure_inclusion_of(:value).in_array([1, 2, 3, 4, 5]) }
end
