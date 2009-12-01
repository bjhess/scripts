#! /usr/bin/ruby

install_all = false
File.open("gem_list.txt").each do |line|
  # coderay (0.8.273, 0.8.260, 0.7.4.215)
  match_data = /(\w+) \((.+)\)/.match(line)
  gem_name, versions = match_data[1], match_data[2]
  versions = versions.split(', ')

  versions.each do |version|
    if !install_all
      puts "Install #{gem_name} (v #{version}) gem? (y/n/a)"
      response = gets
      next if response =~ /^n/i
      install_all = true if response =~ /^a/i
    end
    
    puts "Installing #{gem_name} (v #{version})"
    system "sudo gem install #{gem_name} -v #{version}"
  end
end