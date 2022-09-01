# frozen_string_literal: true

Trestle.resource(:courses) do
  menu do
    item :courses, icon: 'fa fa-school', priority: 3
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :name
    column :created_at
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |_course|
    text_field :name
    text_area :short_description
    text_area :long_description
  end
end
