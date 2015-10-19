Element.expose :dropdown, :rating

Document.ready? do
  Element.find('select.dropdown').dropdown
  Element.find('.ui.rating').rating 'setting', 'disable'
  Element['#project_rating'].rating('setting', 'enable').rating 'setting', 'onRate' do |value|
    puts value
    Element['#project_rating'].next.value = value
  end
end