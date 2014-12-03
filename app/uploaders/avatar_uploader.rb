# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path('fallback/' + [version_name, 'no_avatar.png'].compact.join('_'))
  end

  process resize_to_fill: [50, 50]

  version :thumb do
    process resize_to_fill: [25, 25]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
