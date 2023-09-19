# == Schema Information
#
# Table name: tokens
#
#  id            :bigint           not null, primary key
#  crypted_token :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_tokens_on_crypted_token  (crypted_token) UNIQUE
#
class Token < ApplicationRecord
  validates_presence_of :crypted_token
end
