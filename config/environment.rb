# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
::ActiveRecord::SchemaDumper.ignore_tables |= %w(spatial_ref_sys)