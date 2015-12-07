module UsersHelper

  def checkmark_icon_if flag_set=false
    if flag_set
      tag 'i', class: "green checkmark icon"
    else
      tag 'i', class: "red remove icon"
    end
  end
end
