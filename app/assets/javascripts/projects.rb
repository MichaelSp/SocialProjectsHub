Element.expose :dropdown, :rating

def init
  Element['select.dropdown'].dropdown
  Element['.ui.rating'].rating 'disable'
  Element['#project_rating'].rating('enable')
  `$('#project_rating').rating('setting', 'onRate', function(a,b){this.nextSibling.nextSibling.value = a;});`
  Document.on('keypress', '#search') do |e|
    p e.target
    e.target.form.submit
  end
end

Document.ready? { init }
Document.on('page:change'){ init }