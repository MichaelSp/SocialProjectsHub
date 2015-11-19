class Authorization < AuthorizationBase

  def can_all_user?
    forbid unless @user.try(:admin?)
  end

  def can_update_project?
    forbid unless @user.try(:admin?) || @subject.owners.include?(@user)
  end
  alias can_edit_project? can_update_project?
  alias can_destroy_project? can_update_project?

end