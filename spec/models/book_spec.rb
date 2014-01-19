require 'spec_helper'

describe Book do
  it_behaves_like 'a lendable resource'
  it_behaves_like 'a reviewable resource'
end
