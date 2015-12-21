class Project
  def initialize
    Element['select.dropdown:not(.allowAdditions)'].dropdown
    Element['.ui.rating'].rating 'disable'

    @filter = ProjectFilter.new Element['#filter']
    @bg_image = Element['.project img.background']

    Document.on 'scroll' do
      @bg_image.css :top, (Window.scroll.y/-10)
    end
  end
end

class ProjectForm

  def initialize
    # Rating
    Element['#project_rating_stars'].rating('enable')
    `$('#project_rating_stars').rating('setting', 'onRate', function(val){$(this).next('input').val(val);});`

    # Categories
    Element['select.dropdown.allowAdditions'].dropdown `{"allowAdditions": true}`

    #Language Tabs
    Element['.menu .item'].tab
    Element['#language.ui.dropdown'].dropdown(`{onChange: function(v,t){ self.$add_language(v,t)}} `).dropdown("save defaults")
  end

  def add_language value, text
    return if Element[".ui.tab[data-tab=\"#{value}\"]"].any?
    tab_en = Element['.ui.tab[data-tab="en"]']
    tab = tab_en.clone
    tab.attr('data-tab', value)
    name = tab.find('#project_name_en')
    name.attr('id', "project_name_#{value}")
    name.attr("name", "project[name_#{value}]")
    name.attr('placeholder', name.attr('placeholder').sub('English', text) )
    description = tab.find('#project_description_en')
    description.attr('id', "project_description_#{value}")
    description.attr("name", "project[description_#{value}]")
    description.attr('placeholder', description.attr('placeholder').sub('English', text) )
    tab_en.after tab
    tab.add_class 'active'
    tab_en.remove_class 'active'

    Element['.menu .item.active'].remove_class 'active'
    menu_item = "<a class=\"item active\" data-tab=\"#{value}\">#{text}</a>"
    `$(#{menu_item}).insertBefore('form .menu .right.item')`
    Element['.menu .item'].tab

    Element["#language.ui.dropdown .item[data-value=\"#{value}\"]"].remove
    Element['#language.ui.dropdown'].dropdown("restore default text").dropdown("refresh")
  end
end
