# frozen_string_literal: true

class RootController < ApplicationController
  def index
    @courses = Course.all
    @teachers = User.all
  end
end
