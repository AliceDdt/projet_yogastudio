# frozen_string_literal: true

Trestle.resource(:teachers) do
  active_storage_fields do
    [:picture]
  end

  menu do
    item :teachers, icon: 'fa fa-user', priority: 2
  end

  # Customize the table columns shown on the index view.
  table do
    column :first_name
    column :last_name
    actions
  end

  # Customize the form fields shown on the new/edit views.
  form do |teacher|
    row do
      col(:sm) do
        text_field :last_name
        text_field :first_name
        email_field :email
        phone_field :phone_number
      end
      col(:sm) do
        fields_for :address, teacher.address || teacher.build_address do
          text_field :street
          text_field :complementary
          text_field :zip_code
          text_field :city
        end
      end
      col(:sm) { active_storage_field :picture }
    end
    divider
    text_area :bio
  end
end
