class ImagesController < ApplicationController
  def create 
    new_image = Image.create(image_key: params[:key], image_url: params[:url])
    new_image
  end
end
