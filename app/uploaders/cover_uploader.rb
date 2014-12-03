# encoding: utf-8

class CoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path('fallback/' + [version_name, 'no_book_cover.png'].compact.join('_'))
  end

  process resize_to_fill: [100, 125]

  version :small do
    process resize_to_fill: [50, 63]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
