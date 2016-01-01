require 'opal_ujs'
require 'opal-browser'
require 'turbolinks'
require 'semantic-ui.js'
require 'local_time'
require 'nprogress'
require 'nprogress-turbolinks'
require 'alertifyjs'
require 'refile'
require_tree '.'

Element.expose :dropdown, :rating, :sticky, :checkbox, :nag, :closest, :transition, :tab, :insert_before

$pages = {}

def try_class cls
  Object.const_get(cls) if Object.const_defined?(cls)
end

def piwik
  `piwik_tracker = Piwik.getTracker(document.location.protocol + "//piwik.staging.inline.de/piwik.php", 1);
  piwik_tracker.trackPageView();
  piwik_tracker.enableLinkTracking();
  `
rescue Exception => e
  puts e.message
end

def init
  Element['.nag'].nag 'show'
  Element['.ui.checkbox'].checkbox 'enable'

  Element['.message .close'].on 'click' do |event|
    event.target.closest('.message').transition('fade')
  end

  controller_name = Document.body.data('controller')
  action_name = Document.body.data('action')

  cls = try_class controller_name
  $pages[cls] = cls.new if cls

  cls = try_class controller_name + action_name
  cls ||= try_class "#{controller_name}Form" if %w{Edit New Update}.include?(action_name)
  $pages[cls] = cls.new if cls

  piwik
end

Document.on('ready page:change') { init }