class AuthorizationBase

  def self.authorize! action, subject, user=nil
    auth = Authorization.new
    forbid unless auth.allowed? action, subject, user
  end

  def subject_name
    case @subject
      when ActiveRecord::Base then
        @subject.class.to_s.underscore
      else
        @subject.to_s.underscore
    end
  end

  def allowed?(action, subject, user=User.current)
    @action, @subject, @user = action, subject, user
    [:"can_all_#{subject_name}?", :"can_#{@action}_#{subject_name}?"].any? do |method|
      send method if respond_to?(method)
    end
  end

  def self.forbid
    raise ApplicationController::AccessDenied.new "Not allowed"
  end

end