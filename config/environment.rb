# Load the rails application
require 'find'
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sem::Application.initialize!

Find.find("#{Rails.root}/lib/spider") do |path|
  if path =~ /\.rb$/
    require path
  end
end
