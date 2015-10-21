Element.expose :dropdown, :rating, :sticky



def init
  Element['select.dropdown'].dropdown

  # Rating
  Element['.ui.rating'].rating 'disable'
  Element['#project_rating'].rating('enable')
  `$('#project_rating').rating('setting', 'onRate', function(val){this.nextSibling.nextSibling.value = val;});`

  # Sticky
  Element['.ui.sticky'].sticky offset: 160

  #
  @filter = ProjectFilter.new Element['#filter']

  # Element['#search'].on(:keypress) do |e|
  #   p e.target
  #   e.target.form.submit
  # end
end

Document.ready? { init }
Document.on('page:change'){ init }