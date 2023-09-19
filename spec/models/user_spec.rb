# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { should have_many(:links) }
    # it  { should have_many(:feeds) }
  end
  
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
  end

  context 'valid User' do 
    it 'valid email, password' do 
      user = User.new(
        email: Faker::Internet.email,
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end 
  end

  context 'invalid' do
    it 'email is blank' do
      user = User.new(
        email: '',
        password: 'password',
        password_confirmation: 'password'
      )

      expect(user).to be_invalid
    end

    it 'email is invalid format' do
      user = User.new(
        email: 'Faker::Internet.email',
        password: 'password',
        password_confirmation: 'password'
      )

      expect(user).to be_invalid
    end

    it 'password is blank' do
      user = User.new(
        email: Faker::Internet.email,
        password: '',
        password_confirmation: ''
      )

      expect(user).to be_invalid
    end

    it 'password is not same with password_confirmation' do
      user = User.new(
        email: Faker::Internet.email,
        password: 'password',
        password_confirmation: 'password123'
      )
      expect(user).to be_invalid
    end

  end
end
