class User < ActiveRecord::Base
  has_and_belongs_to_many :projects

  has_secure_password

  def self.current
    Thread.current[:current_user]
  end

  def self.current=(user)
    Thread.current[:current_user]
  end
end
