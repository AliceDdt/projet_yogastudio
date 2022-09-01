# frozen_string_literal: true

Trestle.resource(:users) do
  remove_action :new, :show, :edit, :update

  menu do
    item :users, icon: 'fas fa-users', priority: 5
  end

  # Customize the table columns shown on the index view.
  table do
    column :id
    column :email
    column :first_name
    column :last_name
    column :created_at, sort: { default: true, default_order: :desc }
    column :updated_at
    actions
  end
end
