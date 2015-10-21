class ProjectFilter
  ESC_KEY = 27

  def initialize form
    @form = form
    search_field_id = '#project_project_name'
    @search_field = @form.find(search_field_id)
    @search_field.focus
    @form.on(:keypress, search_field_id) do |event|
      return clear if event.key_code == ESC_KEY

      @timeout.clear if @timeout
      @timeout = Timeout.new 800 do
        @form.submit
      end
    end
  end

  def clear
    @search_field.value = ''
  end
end