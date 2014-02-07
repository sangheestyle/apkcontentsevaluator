#!/usr/bin/ruby
require "csv"

class ApkLabels
  attr_reader :apk_name, :id, :labels

  def initialize(apk_name, id, labels)
    @apk_name = apk_name
    @id = id
    @labels = labels
  end
end

class ApkLabelsSet
  attr_reader :apk_labels_set

  def initialize(path)
    @apk_labels_set = self.read(path)
  end

  def read(path)
    apk_labels_set = Array.new
    if File.directory?(path)
      apk_labels_set << self.read_directory(path)
    else
      apk_labels_set << self.read_file(path)
    end
    apk_labels_set.flatten
  end

  def read_file(path)
    apk_labels_set = Array.new
    CSV.foreach(path) do |row|
      row = row.collect{|x| x.strip}
      apk_labels = ApkLabels.new(row[0], row[1], row[2..-1])
      apk_labels_set << apk_labels
    end
    return apk_labels_set
  end

  def read_directory(path)
    raise NotImplementedError
  end
end

=begin : for simple testing
al_set = ApkLabelsSet.new(ARGV[0])
al_set.apk_labels_set.each do |labels|
  puts labels.apk_name, labels.id, labels.labels
end
=end
