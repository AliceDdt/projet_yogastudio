Trestle.resource(:yoga_sessions) do
  menu do
    item :yoga_sessions, icon: 'fa fa-star'
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :course
    column :teacher
    column :start_date
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |_yoga_session|
    select :course_id, Course.all, { prompt: 'Select course' }
    select :teacher_id, Teacher.all, { prompt: 'Select teacher' }
    row do
      col { datetime_field :start_date }
      col { datetime_field :end_date }
    end
    number_field :number_participants
    number_field :price
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:yoga_session).permit(:name, ...)
  # end
end
