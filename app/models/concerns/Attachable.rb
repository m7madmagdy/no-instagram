# frozen_string_literal: true

# This module provides functionality for attaching resources and creating avatars.
module Attachable
  extend ActiveSupport::Concern

  included do
    def upload_attachments(parmas, resource)
      return unless parmas[:post][:attachment].present?

      attachments = Array(params[:post][:attachment])
      image_paths = attachments.map { |attachment| attachment.tempfile.path if attachment.present? }.compact
      response = ImgurUploader.upload(image_paths)
      response.each do |image_data|
        resource_id = image_data['data']['id']
        resource_type = image_data['data']['type']
        resource_url = image_data['data']['link']
        create_attachment(resource, response, resource_id, resource_type, resource_url)
      end
    end

    def upload_avatar(parmas, resource)
      return unless parmas[:user][:avatar].present?

      response = ImgurUploader.upload(parmas[:user][:avatar].tempfile.path).compact.first
      create_avatar(resource, response, response['data']['id'], response['data']['type'], response['data']['link'])
    end

    def create_attachment(resource, raw_response, resource_id, resource_type, resource_url)
      resource.attachments.create!(
        raw_response: raw_response,
        resource_id: resource_id,
        resource_type: resource_type,
        resource_url: resource_url
      )
    end

    def create_avatar(resource, raw_response, avatar_id, avatar_type, avatar_url)
      resource.build_avatar(
        raw_response: raw_response,
        avatar_id: avatar_id,
        avatar_type: avatar_type,
        avatar_url: avatar_url
      ).save
    end
  end
end
