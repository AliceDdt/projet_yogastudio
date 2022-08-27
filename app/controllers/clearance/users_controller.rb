# frozen_string_literal: true

module Clearance
  class UsersController < Clearance::BaseController
    before_action :redirect_signed_in_users, only: %i[create new]
    skip_before_action :require_login, only: %i[create new], raise: false

    def show
      @user = current_user
      render template: 'users/show'
    end

    def new
      @user = Clearance.configuration.user_model.new(user_params)
      render template: 'users/new'
    end

    def create
      params = permitted_params.except(:password_confirmation)
      @user = Clearance.configuration.user_model.new(user_params)

      if @user.save
        sign_in @user
        redirect_back_or url_after_create, notice: 'User successfully created'
      else
        flash.now.alert = @user.errors.messages
        render template: 'users/new', status: :unprocessable_entity
      end
    end

    def edit
      @user = current_user
      render template: 'users/edit'
    end

    def update
      @user = current_user
      params = permitted_params.except(:password_confirmation)

      if @user.update(permitted_params)
          redirect_to user_path, notice: 'User successfully updated'
      else
        flash.now.alert = @user.errors.messages
        render template: 'users/edit', status: :unprocessable_entity
      end
    end

    private

    def redirect_signed_in_users
      redirect_to Clearance.configuration.redirect_url if signed_in?
    end

    def url_after_create
      Clearance.configuration.redirect_url
    end

    def user_params
      params[Clearance.configuration.user_parameter] || {}
    end

    def permitted_params
      params.require(:user)
            .permit(:email, :last_name, :first_name, :phone_number, 
                    :password, :password_confirmation,
                    address_attributes: %i[street complementary zip_code city])
    end
  end
end
