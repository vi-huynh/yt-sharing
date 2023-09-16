class Token < ApplicationRecord
  validates_presence_of :crypted_token
end
