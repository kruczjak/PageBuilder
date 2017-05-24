class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :uuid, :created_at, :updated_at, :built_at, :initialized_at
end
