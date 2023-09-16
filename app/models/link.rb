class Link < ApplicationRecord
  belongs_to :sharer, class_name: User.name

  validates_presence_of   :url
end
