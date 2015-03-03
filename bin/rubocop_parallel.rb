#!/usr/bin/env ruby
 
require 'rubocop'
require 'yaml'
 
Dir.chdir File.expand_path('../..', __FILE__)
config = YAML.load_file '.rubocop.yml'
 
files = Dir.glob '**/*.rb'
files += Dir.glob config['AllCops']['Include']
files -= Dir.glob config['AllCops']['Exclude']
 
files.sort!.uniq!
 
node = (ENV['CIRCLE_NODE_INDEX'] || 0).to_i
total = (ENV['CIRCLE_NODE_TOTAL'] || 1).to_i
 
files = files.select.with_index { |_file, i| i % total == node }
 
puts "Running RuboCop on node #{node + 1} of #{total}"
 
exit RuboCop::CLI.new.run(files)
