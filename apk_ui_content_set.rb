#!/usr/bin/ruby
require 'pathname'
require_relative 'apk_content_set'

class ApkUIContentSet < ApkContentSet

  def read_file(path)
    file_name = Pathname.new(path).basename.to_s
    apk_name = file_name[0..-7]
    @type = file_name[-5]
    f = File.open(path, "rb")
    content = f.read
    ApkContent.new(@type, apk_name, @type, content)
  end

  def read_directory(path)
    apk_ui_content = Array.new
    Dir[path+"/**/*-[a-z].txt"].each do |file_path|
      apk_ui_content << self.read_file(file_path)
    end
    apk_ui_content.flatten
  end
end
