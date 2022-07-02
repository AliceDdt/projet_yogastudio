Trestle.resource(:teachers) do
  menu do
    item :teachers, icon: 'fa fa-star'
  end

  # Customize the table columns shown on the index view.
  table do
    column :first_name
    column :last_name
    column :created_at, align: :center
    #   actions
  end

  # Customize the form fields shown on the new/edit views.
  form do |teacher|
    text_field :last_name
    text_field :first_name

    fields_for :address, teacher.address || teacher.build_address do
      text_field :street
      text_field :complementary
      text_field :zip_code
      text_field :city
    end

    phone_field :phone_number
    email_field :email
    file_field :picture
    text_area :bio
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:teacher).permit(:name, ...)
  # end
end
