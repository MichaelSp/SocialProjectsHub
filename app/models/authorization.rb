class Authorization < AuthorizationBase

  def can_all_user
    forbid unless @user.admin?
  end

  def can_update_project
    forbid unless @user.admin? || @subject.owners.include?(@user)
  end

  def can_destroy_project
    can_update_project
  end
end