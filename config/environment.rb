# Load the rails application
require File.expand_path('../application', __FILE__)

#
# Time formats
#
Time::DATE_FORMATS[:member_since] = "%d %B, %Y"

# Initialize the rails application
OpenMarket::Application.initialize!
