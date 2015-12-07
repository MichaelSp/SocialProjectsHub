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
    Element['#language.ui.dropdown'].dropdown(`{onChange: self.$add_language}`)
  end

  def add_language value, text
    menu_active = Element['#lang_menu .item.active']
    menu_item = menu_active.clone
    menu_active.remove_class 'active'

    Element[menu_item].insert_before 'form .menu .right.item'
  end
end
