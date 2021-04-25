# frozen_string_literal: true

class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # デフォルト画像の設定
  def default_url(*_args)
    ActionController::Base.helpers.asset_path('fallback/' + [version_name, 'default.png'].compact.join('_'))
  end

  process resize_to_limit: [225, 300]
  process convert: 'jpg' # 保存形式をJPGにする

  storage :file

  # サムネイルを生成する設定

  version :thumb do
    process resize_to_limit: [300, 300]
  end

  version :thumb100 do
    process resize_to_limit: [100, 100]
  end

  version :thumb30 do
    process resize_to_limit: [30, 30]
  end

  # storage :file の時の画像の保存場所を指定
  def store_dir
    if Rails.env.test? # テスト画像は一括削除できるようにフォルダを別にする
      "uploads_#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  # アップロード可能な拡張子のリスト
  def extension_white_list
    %w[jpg jpeg gif png]
  end

  def filename
    original_filename
  end
end
