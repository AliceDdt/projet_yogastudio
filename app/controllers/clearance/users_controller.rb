# frozen_string_literal: true

module Clearance
  class UsersController < Clearance::BaseController
    before_action :redirect_signed_in_users, only: %i[create new]
    skip_before_action :require_login, only: %i[create new], raise: false

    def new
      @user = user_from_params
      render template: 'users/new'
    end

    def create
      @user = user_from_params

      if @user.save
        sign_in @user
        redirect_back_or url_after_create
      else
        flash.now.alert = @user.errors.messages
        render template: 'users/new', status: :unprocessable_entity
      end
    end

    private

    def redirect_signed_in_users
      redirect_to Clearance.configuration.redirect_url if signed_in?
    end

    def url_after_create
      Clearance.configuration.redirect_url
    end

    def user_from_params
      email = user_params.delete(:email)
      password = user_params.delete(:password)
      last_name = user_params.delete(:last_name)
      first_name = user_params.delete(:first_name)
      phone_number = user_params.delete(:phone_number)

      Clearance.configuration.user_model.new(user_params).tap do |user|
        user.email = email
        user.password = password
        user.last_name = last_name
        user.first_name = first_name
        user.phone_number = phone_number
      end
    end

    def user_params
      params[Clearance.configuration.user_parameter] || {}
    end
  end
end
