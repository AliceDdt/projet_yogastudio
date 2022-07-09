# frozen_string_literal: true

class BookingsController < ApplicationController
  def create
    @booking = Booking.new(create_params.merge(user: current_user))

    if @booking.save
      respond_to do |format|
        format.html { redirect_to yoga_sessions_path, notice: 'Booking was successfully created.' }
        format.turbo_stream
      end
      # redirect_to yoga_sessions_path, notice: 'Booking was successfully created.'
    else
      redirect_to yoga_sessions_path, notice: 'toto'
    end
  end

  def create_params
    params.require(:booking).permit(:yoga_session_id)
  end
end
