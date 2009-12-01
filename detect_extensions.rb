# usage ruby extensions.rb [target_folder]
#
# List all extensions in target folder and subdirectories, including total unique count.

require 'pathname'
require 'fileutils'
require 'optparse'
require 'ostruct'

# Option parser, thanks to: http://ruby.about.com/od/scripting/a/commandline_arg_2.htm
options = OpenStruct.new
options.verbose = false

opts = OptionParser.new do |opts|
  opts.on("-v", "--verbose", "Display verbose output.") do |v|
    options.verbose = v
  end
  opts.on_tail("-h", "--help", "Show this usage statement") do |h|
    puts opts
  end
end

begin
  opts.parse!(ARGV)
rescue Exception => e
  puts e, "", opts
  exit
end

target_folder = ARGV[0] || raise("No target folder provided")
extensions    = []

if target_folder
  Dir["#{target_folder}/**/*"].each do |file_name|
    split_file_name = file_name.split('/').last.split('.')
    extensions << split_file_name.last if split_file_name.size > 1
    extensions.uniq!
  end
  
  extensions.each do |extension|
    puts extension
  end  
  puts "TOTAL UNIQUE EXTENSIONS: #{extensions.size}"
end

