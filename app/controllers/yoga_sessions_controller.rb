# frozen_string_literal: true

class YogaSessionsController < ApplicationController
  def index
    @yoga_sessions = YogaSession.all.order(start_date: :asc, created_at: :asc)
  end

  def book
    @yoga_session = YogaSession.find(params[:yoga_session_id])
    @yoga_session.bookings.new(user: current_user)

    if @yoga_session.save
      respond_to do |format|
        format.html { redirect_to yoga_sessions_path, notice: 'Booking was successfully created.' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to yoga_sessions_path, notice: 'toto' }
        format.turbo_stream { flash.now[:alert] = 'toto' }
      end
    end
  end
end
