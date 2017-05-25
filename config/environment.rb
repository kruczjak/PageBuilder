# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

`mkdir #{Rails.public_path.join('projects')}`
