class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content
  belongs_to :user
  belongs_to :channel

end
