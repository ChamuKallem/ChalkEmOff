class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :complete, :user_id
end
