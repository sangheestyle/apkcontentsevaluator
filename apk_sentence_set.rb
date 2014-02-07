#!/usr/bin/ruby

class ApkSentence
  attr_reader :apk_name, :id, :sentence

  def initialize(apk_name, id, sentence)
    @apk_name = apk_name
    @id = id
    @words = words
  end
end
