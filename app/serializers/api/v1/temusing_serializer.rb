class Api::V1::TemusingSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :updated_at, :status
  belongs_to :template, serializer: Api::V1::TemplateSerializer
end
