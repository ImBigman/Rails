# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
Time::DATE_FORMATS[:js_datetime] = '%B %d %Y %H:%M:%S'

