require 'spec_helper'

describe User, :type => :model do
  it_behaves_like 'a authorizable resource'
end

