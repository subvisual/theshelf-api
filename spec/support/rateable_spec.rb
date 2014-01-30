shared_examples 'a rateable resource' do
  let(:resource) { create(described_class.to_s.underscore) }

  context '#update_average_rating!' do
    it 'updates the average rating' do
      user = build_stubbed :user
      create(:rating, book: resource, rater: user, value: 2)
      create(:rating, book: resource, rater: user, value: 3)

      resource.update_average_rating!

      expect(resource.average_rating).to eq 2.5
    end
  end

  context '#rating_by' do
    it 'returns the rating given by the user' do
      user = build_stubbed :user
      rating = create(:rating, book: resource, rater: user, value: 2)

      expect(resource.rating_by(user)).to eq rating
    end
  end
end
