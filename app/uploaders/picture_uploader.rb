# frozen_string_literal: true

class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [225, 300]
  storage :file

  # アップロードファイルの保存先ディレクトリは上書き可能
  # 下記はデフォルトの保存先
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def default_url(*)
    model_name = model.class.name
    if model_name == 'User'
      return "/default/#{[version_name,
                          'default_user.png'].compact.join('_')}"
    end
    if model_name == 'Item'
      return "/default/#{[version_name,
                          'default_item.png'].compact.join('_')}"
    end
    if model_name == 'Cordinate'
      return "/default/#{[version_name,
                          'default_cordinate.png'].compact.join('_')}"
    end

    # クラスがユーザ以外の場合は、no_imageの画像を使用する
    "/default/#{[version_name, 'no_image.png'].compact.join('_')}"
  end

  # アップロード可能な拡張子のリスト
  def extension_white_list
    %w[jpg jpeg gif png]
  end

  def filename
    original_filename
  end
end
