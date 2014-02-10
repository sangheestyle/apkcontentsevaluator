#!/usr/bin/ruby
require 'csv'

class ApkContent
  attr_reader :type, :name, :id, :content

  def initialize(type, name, id, content)
    @type, @name, @id, @content = type, name, id, content
  end
end

class ApkContentSet
  attr_reader :content_set

  def initialize(path, type=NIL)
    @type = type
    @content_set = read(path)
  end

  def read(path)
    content_set = Array.new
    if File.directory?(path)
      content_set << read_directory(path)
    else
      content_set << read_file(path)
    end
    content_set.flatten
  end

  def read_file(path)
    content_set = Array.new
    CSV.foreach(path) do |row|
      row = row.collect{|x| x.strip}
      content = ApkContent.new(@type, row[0], row[1], row[2..-1])
      content_set << content
    end
    return content_set
  end

  def read_directory(path)
    content_set = Array.new
    Dir[path + "/**/#{@type}*.*"].each do |file_path|
      content_set << read_file(file_path)
    end
    content_set
  end
end