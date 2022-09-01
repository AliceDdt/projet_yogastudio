# frozen_string_literal: true

Trestle.resource(:bookings) do
  remove_action :new, :edit, :update

  menu do
    item :bookings, icon: 'fa fa-calendar', priority: 4
  end

  # Allow to search Bookings by user or by yoga course name
  search do |query|
    if query
      collection.left_joins(:user, yoga_session: [:course])
                .where(
                  "CONCAT_WS(' ', users.first_name, users.last_name) ILIKE ?
          OR CONCAT_WS(' ', users.last_name, users.first_name) ILIKE ?
          OR users.email ILIKE ?
          OR courses.name ILIKE ?",
                  "%#{query}%",
                  "%#{query}%",
                  "%#{query}%",
                  "%#{query}%"
                )
    else
      collection
    end
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :user, ->(booking) { booking.user.email }
    column :yoga_session, ->(booking) { booking.yoga_session.course.name }
    column :date_yoga_session, ->(booking) { booking.yoga_session.start_date }
    column :created_at, align: :center
    actions
  end
end
