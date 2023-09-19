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
require 'rails_helper'

RSpec.describe Link, type: :model do
  context 'associations' do
    it { should belong_to(:sharer) }
    # it  { should have_many(:feeds) }
  end
  
  context 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  context 'valid Link' do 
    it 'valid url, title, description' do 
      link = Link.new(
        url: Faker::Internet.url, 
        title: Faker::Lorem.sentence, 
        description: Faker::Lorem.sentence, 
        sharer: FactoryBot.create(:user)
      )
      expect(link).to be_valid
    end 
  end

  context 'invalid' do
    it 'sharer is blank' do
      link = Link.new(
        url: '', 
        title: Faker::Lorem.sentence, 
        description: Faker::Lorem.sentence
      )
      expect(link).to be_invalid
    end

    it 'url is blank' do
      link = Link.new(
        url: '', 
        title: Faker::Lorem.sentence, 
        description: Faker::Lorem.sentence,
        sharer: FactoryBot.create(:user)
      )
      expect(link).to be_invalid
    end

    it 'tile is blank' do
      link = Link.new(
        url: Faker::Internet.url, 
        title: '', 
        description: Faker::Lorem.sentence,
        sharer: FactoryBot.create(:user)
      )
      expect(link).to be_invalid
    end

    it 'description is blank' do
      link = Link.new(
        url: Faker::Internet.url, 
        title: Faker::Lorem.sentence, 
        description: '',
        sharer: FactoryBot.create(:user)
      )
      expect(link).to be_invalid
    end

  end
end
