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
class User < ApplicationRecord
  has_secure_password

  has_many    :links,      foreign_key: 'sharer_id'
  # has_many    :feeds

  validates             :email, presence: true, email: true, uniqueness: { case_sensitive: true }
  validates_presence_of :password_confirmation, :if => :password_digest_changed?

  # def unread_notifcations
  #   feeds.where(confirmed_at: nil).count
  # end
end
