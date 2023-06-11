# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]
  protect_from_forgery with: :null_session

  def create
    build_resource(sign_up_params)
    resource_saved = resource.save

    yield resource if block_given?

    if resource_saved
      if resource.active_for_authentication?
        if params[:user][:avatar].present?
          response = ImgurUploader.upload(params[:user][:avatar].tempfile.path)
          avatar_id = response["data"]["id"]
          avatar_type = response["data"]["type"]
          avatar_url = response["data"]["link"]
            resource.avatars.create(
              raw_response: response,
              avatar_id: avatar_id,
              avatar_type: avatar_type,
              avatar_url: avatar_url
            )
        end
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

  
  protected

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :bio, :username, avatar_attributes: [ :raw_response, :avatar_id, :avatar_type, :avatar_url ] )
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :bio, :avatar])
  end
end
