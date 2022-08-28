Trestle.resource(:users) do
  remove_action :new, :edit, :update, :destroy

  menu do
    item :users, icon: "fas fa-users", priority: 5
  end

  # Customize the table columns shown on the index view.
  table do
    column :id
    column :email
    column :first_name
    column :last_name
    column :created_at, sort: { default: true, default_order: :desc }
    column :updated_at
  end

  # Customize the form fields shown on the new/edit views.
  #
  # form do |user|
  #   text_field :name
  #
  #   row do
  #     col { datetime_field :updated_at }
  #     col { datetime_field :created_at }
  #   end
  # end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:user).permit(:name, ...)
  # end
end
