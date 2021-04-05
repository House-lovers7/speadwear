# frozen_string_literal: true

class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
   
# このアップローダーを利用した画像の最大数を指定
 process resize_to_fit: [800, 800]

  # 上記とは別にサムネイルを別サイズで用意。
  version :thumb do
    process resize_to_fill: [200, 200]
   end


  storage :file

  # アップロードファイルの保存先ディレクトリは上書き可能

   # storage :file の時の画像の保存場所を指定
 def store_dir
  if Rails.env.test? #テスト画像は一括削除できるようにフォルダを別にする
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

#デフォルト画像の設定
  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
    #   For Rails 3.1+ asset pipeline compatibility:
      ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default_user.png"].compact.join('_'))
    #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    end


  # アップロード可能な拡張子のリスト
  def extension_white_list
    %w[jpg jpeg gif png]
  end

  def filename
    original_filename
  end
end
