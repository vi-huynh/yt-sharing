# == Schema Information
#
# Table name: links
#
#  id          :bigint           not null, primary key
#  description :string
#  title       :string
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sharer_id   :bigint
#  video_id    :string
#
# Indexes
#
#  index_links_on_sharer_id  (sharer_id)
#  index_links_on_video_id   (video_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (sharer_id => users.id)
#
FactoryBot.define do
  factory :link do
    url { Faker::Internet.url }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    
  end
end
