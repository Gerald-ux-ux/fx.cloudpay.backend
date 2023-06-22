class OpeningSerializer < ActiveModel::Serializer
  attributes :id, :amount, :formatted_date
  has_one :user
end
