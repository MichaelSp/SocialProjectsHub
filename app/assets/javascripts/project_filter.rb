class ProjectFilter
  ESC_KEY = 27

  def initialize form
    @form = form
    init_search
    init_categories
  end

  def init_categories
    @categories = @form.find('#project_category_ids')
    @form.on 'click', 'a.category' do |event|
      event.target.toggle_class('red')
      @categories.value = @form.find('a.category.red').map do |elem|
        elem.data('id')
      end
      @form.submit
    end
  end

  def init_search
    search_field_id = '#project_project_name'
    @search_field = @form.find(search_field_id)
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