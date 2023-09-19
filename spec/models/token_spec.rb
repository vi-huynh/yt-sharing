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
require 'rails_helper'

RSpec.describe Token, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
