dir = "#{File.dirname(__FILE__)}"
require "#{dir}/spider/base"

Find.find("#{rails_root}/lib/spider") do |path|
  require path if path =~ /\.rb$/
end