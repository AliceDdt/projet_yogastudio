class UserResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  field :first_name, as: :text
  field :last_name, as: :text
  field :phone_number, as: :text
  field :email, as: :text
  field :password, as: :text

  field :address, as: :has_one
  # add fields here
end
