class YogaSessionResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  field :date, as: :date_time
  field :number_booking, as: :number
  field :number_participants, as: :number
  field :price, as: :number
  field :course, as: :belongs_to
  field :teacher, as: :belongs_to
end
