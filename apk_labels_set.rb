#!/usr/bin/ruby

class ApkLabels
  attr_reader :apk_name, :id, :labels

  def initialize(apk_name, id, labels)
    @apk_name = apk_name
    @id = id
    @labels = labels
  end
end
