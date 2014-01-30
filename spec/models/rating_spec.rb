require 'spec_helper'

describe Rating do
  it { should ensure_inclusion_of(:value).in_array([1,2,3,4,5]) }
end
