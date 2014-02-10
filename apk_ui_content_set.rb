#!/usr/bin/ruby
require 'pathname'

class ApkUIContent
  attr_reader :apk_name, :version, :content

  def initialize(apk_name, version, contents)
    @apk_name = apk_name
    @version = version
    @content = contents
  end
end

class ApkUIContentSet
  attr_reader :apk_ui_content_set

  def initialize(path)
    @apk_ui_content_set = self.read(path)
  end

  def read(path)
    apk_ui_content = Array.new
    if File.directory?(path)
      apk_ui_content << self.read_directory(path)
    else
      apk_ui_content << self.read_file(path)
    end
    apk_ui_content.flatten
  end

  def read_file(file_path)
    file_name = Pathname.new(file_path).basename.to_s
    apk_name = file_name[0..-7]
    version = file_name[-5]
    f = File.open(file_path, "rb")
    contents = f.read
    ApkUIContent.new(apk_name, version, contents)
  end

  def read_directory(path)
    apk_ui_content = Array.new
    Dir[path+"/**/*-[a-z].txt"].each do |file_path|
      apk_ui_content << self.read_file(file_path)
    end
    apk_ui_content.flatten
  end
end
