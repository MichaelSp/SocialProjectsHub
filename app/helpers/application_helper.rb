module ApplicationHelper

  def can? action, subject
    @authorize ||= Authorization.new
    @authorize.allowed? action, subject, User.current
  end
end
