class User < ApplicationRecord
  has_secure_password

  has_many    :links,      foreign_key: 'sharer_id'
  has_many    :feeds

  validates             :email, presence: true, email: true, uniqueness: { case_sensitive: true }
  validates_presence_of :password_confirmation, :if => :password_digest_changed?

  def unread_notifcations
    feeds.where(confirmed_at: nil).count
  end
end
