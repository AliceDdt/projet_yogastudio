# frozen_string_literal: true

class BookingsController < ApplicationController
  def create
    @booking = Booking.new(create_params.merge(user: current_user))

    if @booking.save
      redirect_to yoga_sessions_path, notice: 'Booking was successfully created.'
    else
      redirect_to yoga_sessions_path, status: :unprocessable_entity, notice: 'toto'
    end
  end

  def create_params
    params.require(:booking).permit(:yoga_session_id)
  end
end
