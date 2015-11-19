class User < ActiveRecord::Base
  has_and_belongs_to_many :projects

  validates_presence_of :password_digest, :email

  has_secure_password

  validate do
    errors.add(:admin?, :cant_revoke_self) if User.current == self
  end

  def self.roles
    {admin: 1}
  end

  def admin?
    roles & self.class.roles[:admin] == 1
  end

  def admin= value
    if value.to_i == 1
      self.roles = roles | self.class.roles[:admin]
    else
      self.roles = roles & ~(self.class.roles[:admin])
    end
  end

  def self.current
    Thread.current[:current_user]
  end

  def self.current=(user)

    Thread.current[:current_user] = user
  end
end
