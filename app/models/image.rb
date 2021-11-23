require 'base64'

class Image < ApplicationRecord

  def self.create_base64_image(filepath)
    Base64.encode64(File.open(filepath, "rb").read)
  end

end
