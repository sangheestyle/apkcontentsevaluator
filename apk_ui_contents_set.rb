#!/usr/bin/ruby
require 'pathname'

class ApkUIContents
  attr_reader :apk_name, :version, :contents

  def initialize(apk_name, version, contents)
    @apk_name = apk_name
    @version = version
    @contents = contents
  end
end

class ApkUIContentsSet
  attr_reader :apk_ui_contents_set

  def initialize(path)
    @apk_ui_contents_set = self.from(path)
  end

  def from(path)
    apk_ui_contents = Array.new
    if File.directory?(path)
      apk_ui_contents << self.from_directory(path)
    else
      apk_ui_contents << self.from_file(path)
    end
    apk_ui_contents.flatten
  end

  def from_file(file_path)
    file_name = Pathname.new(file_path).basename.to_s
    apk_name = file_name[0..-7]
    version = file_name[-5]
    f = File.open(file_path, "rb")
    contents = f.read
    ApkUIContents.new(apk_name, version, contents)
  end

  def from_directory(path)
    apk_ui_contents = Array.new
    Dir[path+"/**/*-[a-z].txt"].each do |file_path|
      apk_ui_contents << self.from_file(file_path)
    end
    apk_ui_contents.flatten
  end
end
