require 'rubygems'
Gem.clear_paths

require 'parseconfig'

config = ParseConfig.new("#{ENV['BUILD_DIR']}/.gitmodules")

config.get_params.each do |param|
  next unless param.match(/^submodule/)
  c = config[param]

  puts "---> parsing ENV branch: #{ENV['BUILDPACK_BRANCH']}"
  branch_flag = ENV['BUILDPACK_BRANCH'] ? "-b #{ENV['BUILDPACK_BRANCH']}" : c["branch"] ? "-b #{c['branch']}" : ""
  puts "---> Installing submodule #{c["path"]} #{branch_flag}"
  `git clone #{c["url"]} #{branch_flag} #{ENV['BUILD_DIR']}/#{c["path"]}`

  puts "----> Removing submodule git folder"
  `rm -rf #{ENV['BUILD_DIR']}/#{c["path"]}/.git`
end
