#!/usr/bin/ruby
require 'csv'

class ApkSentence
  attr_reader :apk_name, :id, :sentence

  def initialize(apk_name, id, sentence)
    @apk_name = apk_name
    @id = id
    @sentence = sentence
  end
end

class ApkSentenceSet
  attr_reader :apk_sentence_set

  def initialize(path)
    @apk_sentence_set = self.read(path)
  end

  def read(path)
    apk_sentence_set = Array.new
    if File.directory?(path)
      apk_sentence_set << self.read_directory(path)
    else
      apk_sentence_set << self.read_file(path)
    end
    apk_sentence_set.flatten
  end

  def read_file(path)
    apk_sentence_set = Array.new
    CSV.foreach(path) do |row|
      row = row.collect{|x| x.strip}
      apk_sentence = ApkSentence.new(row[0], row[1], row[2..-1])
      apk_sentence_set << apk_sentence
    end
    return apk_sentence_set
  end

  def read_directory(path)
    raise NotImplementedError
  end
end
