class Project
  def initialize
    Element['select.dropdown'].dropdown

    Element['.ui.rating'].rating 'disable'

    # Sticky
    Element['.ui.sticky'].sticky offset: 160

    @filter = ProjectFilter.new Element['#filter']
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
    Element['#project_rating'].rating('enable')
    `$('#project_rating').rating('setting', 'onRate', function(val){this.nextSibling.nextSibling.value = val;});`

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
