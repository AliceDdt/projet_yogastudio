class AddressResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  field :street, as: :text
  field :completary, as: :text
  field :city, as: :text
  field :zip_code, as: :text

end
