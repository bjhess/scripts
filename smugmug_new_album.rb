require "rubygems"
require "smugmugapi"
require "stringio"
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

source = ARGV[0]  # centered in the photo are of my server
title  = ARGV[1] || "Forgotten album title"
desc   = ARGV[2] || ""

SmugMugAPI.api_version = '1.2.1'
smugmug.login("barry@bjhess.com", 'xxxxxx')

category = smugmug.categories.get.find { |e| e.name.match(/family/i) }
sharegroup = smugmug.sharegroups.get.find { |e| e.name.match(/family/i) }
album = smugmug.albums.create \
  :title => title,
  :category_id => category.id,
  :sharegroup_id => sharegroup.id,
  :description => desc,
  # :keywords => 'blue apple foo bar',
  :public => false

smugmug.sharegroups.add_album(:share_group_id => sharegroup.id, :album_id => album.id)

photo_count = 0
# TODO: Sort by date before looping to give nice order to online gallery.
# TODO: Allow AVI upload.
Dir["/Volumes/homewrite/photos/family/full_quality/#{source}/**/*.{jpg,JPG,jpeg,JPEG,raw,RAW,tif,TIF,gif,GIF,png,PNG}"].each do |file_name|

  smugmug.upload(file_name, :album_id => album.id)
  puts "Photo: [#{file_name}] uploaded..."
  photo_count += 1
end

puts "PHOTOS UPLOADED: #{photo_count} [TO: #{title}]"

smugmug.logout