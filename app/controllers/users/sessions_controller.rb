# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session

  def create
    warden.authenticate!(scope: resource_name, recall: "#{controller_path}#new")
    current_user.generate_token
    current_user.save
    current_user.reload
    render json: { user: current_user, status: :ok }
  end
end
