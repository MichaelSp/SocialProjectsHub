class AuthorizationBase

  def self.authorize! action, subject, user
    auth = Authorization.new action, subject, user
    auth.allowed?
  end

  def initialize(action, subject, user)
    @action, @subject, @user = action, subject, user
  end


  def subject_name
    case @subject
      when ActiveRecord then
        @subject.class.to_s.underscore
      else
        @subject.to_s.underscore
    end
  end

  def allowed?
    [:"can_all_#{subject_name}?", :"can_#{@action}_#{subject_name}?"].each do |method|
      send method if respond_to?(method)
    end
  end

  def forbid
    raise ApplicationController::AccessDenied.new "Not allowed"
  end

end