require 'rubygems'
Gem.clear_paths

require 'parseconfig'
config = ParseConfig.new("#{ENV['BUILD_DIR']}/.gitmodules")

config.get_params.each do |param|
  next unless param.match(/^submodule/)
  c = config[param]

  branch_flag = "-b master"
  puts "---> Installing submodule #{c["path"]} #{branch_flag}"
  `git clone #{c["url"]} #{branch_flag} #{ENV['BUILD_DIR']}/#{c["path"]}`

  puts "----> Removing submodule git folder"
  `rm -rf #{ENV['BUILD_DIR']}/#{c["path"]}/.git`
end
