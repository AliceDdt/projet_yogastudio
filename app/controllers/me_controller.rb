# frozen_string_literal: true

class MeController < ApplicationController
  def show
    @user = current_user
    render 'users/show'
  end

  def edit
    @user = current_user
    render 'users/edit'
  end

  def update
    @user = current_user.update(user_params)

    if @user.save
      redirect_to me_path, notice: 'User successfully updated'
    else
      render template: 'users/edit', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :phone_number, :password)
  end
end
