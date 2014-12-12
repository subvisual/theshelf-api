require 'spec_helper'

describe GuestUser, type: :model do
  it 'returns nil for any method' do
    expect(GuestUser.new.random?).to be nil
  end
end
