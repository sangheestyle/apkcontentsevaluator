#!/usr/bin/ruby
require_relative "apk_ui_contents_set"

path = ARGV[0]
new_set = ApkUIContentsSet.new(path)
new_set.apk_ui_contents_set.each do |apk|
  puts "apk name: " + apk.apk_name
  puts "version: " + apk.version
  puts "contents length: " + apk.contents.length.to_s
end
