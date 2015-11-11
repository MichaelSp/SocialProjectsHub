class Project
  def initialize
    Element['select.dropdown'].dropdown
    Element['.ui.rating'].rating 'disable'
    Element['.ui.radio.checkbox'].checkbox

    @filter = ProjectFilter.new Element['#filter']
    @bg_image = Element['.project img.background']

    Document.on 'scroll' do
      @bg_image.css :top, (Window.scroll.y/-10)
    end
  end
end

class Alertify
  class << self
    def prompt name, &block
      `alertify.prompt(name, function(){block.apply(null, arguments)})`
    end
  end
end

class ProjectForm

  def initialize
    # Rating
    Element['#project_rating_stars'].rating('enable')
    `$('#project_rating_stars').rating('setting', 'onRate', function(val){$(this).next('input').val(val);});`

    # Categories
    Element['a.add_category'].on 'click' do
      Alertify.prompt "Add a new category" do |e|
        if (e)
          combo = Element['#project_category_ids']
          combo.append("<option value=\"#{e}\" selected=\"selected\">#{e}</option>")
          combo.dropdown('set selected', e)
        end
      end
    end
  end
end
