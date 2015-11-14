class User < ActiveRecord::Base
  has_and_belongs_to_many :projects

  validates_presence_of :password_digest, :email

  has_secure_password

  def self.roles
    {admin: 1}
  end

  def admin?
    roles & self.class.roles[:admin] == 1
  end

  def admin= value
    self.roles = roles | value.to_i * self.class.roles[:admin]
  end

  def self.current
    Thread.current[:current_user]
  end

  def self.current=(user)

    Thread.current[:current_user] = user
  end
end
