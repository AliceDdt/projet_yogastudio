# frozen_string_literal: true

class YogaSessionsController < ApplicationController
  def index
    @yoga_sessions = YogaSession.where('start_date >= NOW()')
                                .order(start_date: :asc, created_at: :asc)
  end
end
