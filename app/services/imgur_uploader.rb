# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'base64'
require 'json'

# ImgurUploader is responsible for uploading images to Imgur.
class ImgurUploader
  BASE_URL = 'https://api.imgur.com/3/upload.json'

  def self.upload(image_paths)
    images_data = []
    Array(image_paths).each do |image_path|
      image_data = encode_image(image_path)
      params = build_params(image_data)
      response = send_request(params)
      images_data << parse_response(response)
    end
    images_data
  end

  def self.encode_image(image_path)
    Base64.encode64(File.read(image_path, mode: 'rb'))
  end

  def self.build_params(image_data)
    { image: image_data }
  end

  def self.send_request(params)
    uri = URI.parse(BASE_URL)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(uri.path)
    request['Authorization'] = ENV['IMGUR_ACCESS_TOKEN']
    request.set_form_data(params)
    https.request(request)
  end

  def self.parse_response(response)
    JSON.parse(response.body)
  end
end
