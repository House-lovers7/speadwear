# frozen_string_literal: true

class ImageProcessingJob
  include Sidekiq::Worker

  def perform(cordinate_id)
    cordinate = Cordinate.find_by(id: cordinate_id)
    return unless cordinate && cordinate.picture.present?

    begin
      image_path = cordinate.picture.path
      img = MiniMagick::Image.open(image_path)
      # Resize to fill equivalent: resize to cover and then crop
      img.combine_options do |cmd|
        cmd.resize '169x225^'
        cmd.gravity 'center'
        cmd.extent '169x225'
      end
      img.write(image_path)
    rescue => e
      Rails.logger.error("ImageProcessingJob failed for cordinate #{cordinate_id}: #{e.message}")
    end
  end
end 