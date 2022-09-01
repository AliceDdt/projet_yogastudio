# frozen_string_literal: true

Trestle.resource(:administrators, model: Administrator, scope: Auth) do
  menu do
    group :configuration, priority: :last do
      item :administrators, icon: 'fas fa-users'
    end
  end

  table do
    column :id
    column :email, link: true
    column :first_name
    column :last_name
    actions do |a|
      a.delete unless a.instance == current_user
    end
  end

  form do |_administrator|
    text_field :email

    row do
      col(sm: 6) { text_field :first_name }
      col(sm: 6) { text_field :last_name }
    end

    row do
      col(sm: 6) { password_field :password }
      col(sm: 6) { password_field :password_confirmation }
    end
  end
end
