# This file is used by Rack-based servers to start the application.
require 'rack/contrib'

require ::File.expand_path('../config/environment', __FILE__)

use Rack::Locale

run Rails.application
