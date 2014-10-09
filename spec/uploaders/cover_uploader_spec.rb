require 'spec_helper'
require 'carrierwave/test/matchers'

describe CoverUploader, type: :model do
  include CarrierWave::Test::Matchers

  before do
    CoverUploader.enable_processing = true
    @book = Book.new
    @uploader = CoverUploader.new(@book, :cover)
    @uploader.store!(File.open("#{Rails.root}/spec/fixtures/images/example.png"))
  end

  after do
    CoverUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the small version' do
    it 'is scaled should scale down an image to be exactly 50 by 62.5 pixels' do
      expect(@uploader.small).to have_dimensions(50, 63)
    end
  end

  context 'not allowed file type' do
    it 'does not save it' do
      expect {
        @uploader.store!(File.open("#{Rails.root}/spec/fixtures/images/bad_example.gif"))
      }.to raise_error CarrierWave::IntegrityError
    end
  end
end
