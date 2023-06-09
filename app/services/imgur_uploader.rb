require 'net/http'
require 'uri'
require 'base64'
require 'json'

class ImgurUploader
  BASE_URL = 'https://api.imgur.com/3/upload.json'

  def self.upload(image_path)
    imagedata = Base64.encode64(File.read(image_path, mode: 'rb'))
    params = { image: imagedata }
    uri = URI.parse(BASE_URL)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(uri.path)
    request['Authorization'] = "Bearer 853af53a1bfd5cec9e14a66ac4d4f4e9057b9240"
    request.set_form_data(params)
    response = https.request(request)
    JSON.parse(response.body)
  end
end