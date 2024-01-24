# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session

  include Attachable

  def create
    build_resource(sign_up_params)
    resource_saved = resource.save

    yield resource if block_given?

    if resource_saved
      if resource.active_for_authentication?
        upload_avatar(params, resource) if params[:user][:avatar].present?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
  
    if update_resource(resource, update_params)
      upload_avatar(params, resource) if params[:user][:avatar].present?
      set_flash_message :notice, :updated if is_flashing_format?
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :bio, :username, :token, :role, avatar_attributes: [ :raw_response, :avatar_id, :avatar_type, :avatar_url ] )
  end

  def update_params
    params.require(:user).permit(:email, :token, :password, :password_confirmation, :current_password, :bio, :username, :role, avatar_attributes: [:raw_response, :avatar_id, :avatar_type, :avatar_url])
  end
end
