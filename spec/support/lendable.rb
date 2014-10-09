shared_examples 'a lendable resource' do
  let(:resource) { create(described_class.to_s.underscore) }

  LoanStates.all.each do |state|
    context "#make_#{state}" do
      it "sets the resource's state to #{state}" do
        resource.send(:"make_#{state}")

        expect(resource).to send("be_#{state}")
      end
    end
  end

  context 'on initialization' do
    it 'is available by default' do
      expect(resource).to be_available
    end
  end
end
