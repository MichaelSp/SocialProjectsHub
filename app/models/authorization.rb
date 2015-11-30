class Authorization < AuthorizationBase

  def can_all_user?
    @user.try(:admin?)
  end

  def can_create_user? # new registrations
    true
  end

  def can_update_project?
    @user.try(:admin?) || @subject.owners.include?(@user)
  end
  alias can_edit_project? can_update_project?
  alias can_destroy_project? can_update_project?

end