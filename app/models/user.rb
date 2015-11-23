class User < ActiveRecord::Base
  include FlagShihTzu
  has_secure_password

  has_and_belongs_to_many :projects

  validates_presence_of :password_digest, :email
  validate do
    errors.add(:admin?, :cant_revoke_self) if roles_changed? && User.current == self
  end

  has_flags 1 => :admin,
            2 => :moderator,
            column: 'roles'

  def self.current
    Thread.current[:current_user]
  end

  def self.current=(user)
    Thread.current[:current_user] = user
  end
end
