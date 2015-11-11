require 'opal_ujs'
require 'opal-browser'
require 'turbolinks'
require 'semantic-ui.js'
require 'local_time'
require 'alertifyjs'
require 'refile'
require_tree '.'

Element.expose :dropdown, :rating, :sticky, :checkbox, :nag, :closest, :transition

$pages = {}

def try_class cls
  Object.const_get(cls) if Object.const_defined?(cls)
end

def init
  Element['.nag'].nag 'show'
  Element['.message .close'].on 'click' do |event|
    event.target.closest('.message').transition('fade')
  end

  controller_name = Document.body.data('controller')
  action_name = Document.body.data('action')

  cls = try_class controller_name
  $pages[cls] = cls.new if cls

  cls = try_class controller_name + action_name
  cls ||= try_class "#{controller_name}Form" if %w{Edit New}.include?(action_name)
  $pages[cls] = cls.new if cls
end

Document.on('page:change') { init }