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
FactoryBot.define do
  factory :token do
    
  end
end
