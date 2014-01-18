require 'spec_helper'
require 'carrierwave/test/matchers'

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  before do
    AvatarUploader.enable_processing = true
    @user = User.new
    @uploader = AvatarUploader.new(@user, :avatar)
    @uploader.store!(File.open("#{Rails.root}/spec/fixtures/images/example.png"))
  end

  after do
    AvatarUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the thumb version' do
    it 'is scaled should scale down an image to be exactly 25 by 25 pixels' do
      expect(@uploader.thumb).to have_dimensions(25, 25)
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
