# frozen_string_literal: true

class RootController < ApplicationController
  def index
    @courses = Course.all
    @teachers = Teacher.all
  end
end
