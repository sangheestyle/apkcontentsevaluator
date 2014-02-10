#!/usr/bin/ruby
require "csv"

class ApkLabel
  attr_reader :apk_name, :id, :labels

  def initialize(apk_name, id, labels)
    @apk_name = apk_name
    @id = id
    @labels = labels
  end
end

class ApkLabelSet
  attr_reader :apk_label_set

  def initialize(path)
    @apk_label_set = self.read(path)
  end

  def read(path)
    apk_label_set = Array.new
    if File.directory?(path)
      apk_label_set << self.read_directory(path)
    else
      apk_label_set << self.read_file(path)
    end
    apk_label_set.flatten
  end

  def read_file(path)
    apk_label_set = Array.new
    CSV.foreach(path) do |row|
      row = row.collect{|x| x.strip}
      apk_label = ApkLabel.new(row[0], row[1], row[2..-1])
      apk_label_set << apk_label
    end
    return apk_label_set
  end

  def read_directory(path)
    raise NotImplementedError
  end
end
