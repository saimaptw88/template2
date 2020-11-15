class Api::V1::TemplateusingSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :updated_at
  belongs_to :user, serializer: Api::V1::UserSerializer
  belongs_to :template, serializer: Api::V1::TemplateSerializer
end
