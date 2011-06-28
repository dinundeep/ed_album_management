# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
EdAlbum::Application.initialize!
ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.server_settings = {
#    :address => "",
#    :port => 25,
#    :domain => "",
#    :authentication => :login,
#    :user_name => "",
#    :password => "",
# }
# ActionMailer::Base.default_content_type = "text/html"
