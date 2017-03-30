class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :complete
end
