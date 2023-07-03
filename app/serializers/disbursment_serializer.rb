class DisbursmentSerializer < ActiveModel::Serializer
  attributes :id, :disbursment, :date
  has_one :user
end
