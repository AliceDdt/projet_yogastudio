# frozen_string_literal: true

Trestle.resource(:yoga_sessions) do
  menu do
    item :yoga_sessions, icon: 'fa fa-calendar', priority: 1
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :course
    column :teacher
    column :start_date
    column :remaining_seats, ->(yoga_session) { yoga_session.remaining_seats }
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |yoga_session|
    select :course_id, Course.all, prompt: t('admin.yoga_sessions.form.prompts.select_course')
    select :teacher_id, Teacher.all, prompt: t('admin.yoga_sessions.form.prompts.select_teacher')
    row do
      col(:sm) { datetime_field :start_date }
      col(:sm) { datetime_field :end_date }
    end
    row do
      col(:sm) { number_field :number_participants }
      col(:sm) do
        text_field :price #value: yoga_session.price/100.0
      end
    end
  end

  # we want to store price in cents in database
  save_instance do |yoga_session, params|
    yoga_session.price = (params['yoga_session']['price'].tr(',', '.').to_f * 100).to_i
    yoga_session.save
  end
end
