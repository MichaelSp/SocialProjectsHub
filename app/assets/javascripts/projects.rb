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
    Element['#language.ui.dropdown'].dropdown(`{onChange: function(v,t){ self.$add_language(v,t)}} `)
  end

  def add_language value, text
    tab_eng = Element['.ui.tab[data-tab="eng"]']
    tab = tab_eng.clone
    tab.attr('data-tab', value)
    tab.find('#project_name_eng').attr('id', "project_name_#{value}").attr("name", "project[name_#{value}]")
    tab.find('#project_description_eng').attr('id', "project_description_#{value}").attr("name", "project[name_#{value}]")
    tab_eng.after tab
    tab_eng.remove_class 'active'

    Element['.menu .item.active'].remove_class 'active'
    menu_item = "<a class=\"item active\" data-tab=\"#{value}\">#{text}</a>"
    `$(#{menu_item}).insertBefore('form .menu .right.item')`
    Element['.menu .item'].tab
  end
end
