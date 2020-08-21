# frozen_string_literal: true

# This is just a sample uploader, please remove it or rename it to something else
require 'image_processing/mini_magick'
class ImageUploader < Shrine
  # Needed for including processing on images using mini_magick
  plugin :processing
  plugin :versions   # enable Shrine to handle a hash of files
  plugin :delete_raw # delete processed files after uploading
  plugin :moving
  plugin :validation_helpers
  plugin :remote_url, max_size: 20 * 1024 * 1024


  Attacher.validate do
    validate_max_size 8 * 1024 * 1024, message: 'is too large (max is 8 MB)'
    validate_mime_type_inclusion %w(image/jpeg image/png)
  end
end
