require 'opal_ujs'
require 'turbolinks'
require 'semantic-ui.js'
require 'local_time'
require 'alertifyjs'
require_tree '.'

Element.expose :dropdown, :rating, :sticky, :checkbox

$pages = {}

def try_class cls
  Object.const_get(cls) if Object.const_defined?(cls)
end

def init
  controller_name = Document.body.data('controller')
  action_name = Document.body.data('action')

  cls = try_class controller_name
  $pages[cls] = cls.new if cls

  cls = try_class controller_name + action_name
  cls ||= try_class "#{controller_name}Form" if %w{Edit New}.include?(action_name)
  $pages[cls] = cls.new if cls
end

Document.on('page:change') { init }