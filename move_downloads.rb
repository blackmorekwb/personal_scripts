#!/usr/bin/env ruby
require 'fileutils'

base_dir = "/home/blackmore/"

FileUtils.cd(base_dir + "Downloads")

file_types = {
  Videos: ["*.mkv", "*.mp4", "*.wmv", "*.avi", "*.mpg"],
  Documents: ["*.doc*", "*.pdf", "*.txt", "*.odt",
              "*.xls*", "*.ots", "*.rtf"],
  Music: ["*.mp3", "*.m4a", "*.mid", "*.wav", "*.wma"],
  Pictures: ["*.jpg", "*.bmp", "*.gif", "*.png"]
}

file_types.each do |type, extensions|

  destination = base_dir + type.to_s

  puts "\n\nMoving #{type} to: #{destination} \n\n"

  glob = Dir.glob(extensions)

  glob.each do |file|
    puts file
    FileUtils.move file, destination
  end

end
