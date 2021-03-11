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


  if Rails.env.production?
    CarrierWave.configure do |config|
      config.fog_credentials = {
        # Amazon S3用の設定
        :provider              => 'AWS',
        :region                => ENV['S3_REGION'],  # S3に設定したリージョン。
        :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
        :aws_secret_access_key => ENV['S3_SECRET_KEY']
      }
      config.fog_directory     =  ENV['S3_BUCKET']
    end
  end


  def default_url(*)
    model_name = model.class.name
    return "/default/#{[version_name, 'default_user.png'].compact.join('_')}" if model_name == 'User'
    return "/default/#{[version_name, 'default_item.png'].compact.join('_')}" if model_name == 'Item'
    return "/default/#{[version_name, 'default_cordinate.png'].compact.join('_')}" if model_name == 'Cordinate'

    # クラスがユーザ以外の場合は、no_imageの画像を使用する
    "/default/#{[version_name, 'no_image.png'].compact.join('_')}"
  end

  # アップロード可能な拡張子のリスト
  def extension_white_list
    %w[jpg jpeg gif png]
  end
end