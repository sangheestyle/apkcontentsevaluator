#!/usr/bin/ruby
require_relative 'apk_ui_contents_set'
require_relative 'apk_labels_set'

class ApkContentsEvaluator
  attr_reader :evaluations

  def initialize(path_labels, path_ui_contents)
    als = ApkLabelsSet.new(path_labels)
    aucs = ApkUIContentsSet.new(path_ui_contents)
    @apk_labels_set = als.apk_labels_set
    @apk_ui_contents_set = aucs.apk_ui_contents_set
    @evaluations = Array.new
  end

  def calc_match_rate(label, ui_contents_set)
    ui_contents = ui_contents_set.detect{|uc| uc.apk_name == label.apk_name}
    words = label.labels
    found_count = 0
    words.each do |word|
      if ui_contents.contents.scan(word)
        found_count += 1
      end
    end
    rate = Float(words.count) / Float(found_count)
    return [label.apk_name, label.id, words.count, found_count, rate]
  end

  def calc_evaluations()
    @apk_labels_set.each do |label|
      @evaluations << self.calc_match_rate(label, @apk_ui_contents_set)
    end
  end

  def evaluations_for_each_case
    @evaluations
  end

  def evaluate_group_by(apk_name)
    rows = @evaluations.find_all{|row| row[0] == apk_name}
    word_count = 0
    found_count = 0
    rows.each do |row|
      word_count += row[2]
      found_count += row[3]
    end
    rate = Float(word_count) / Float(found_count) * 100
    return [apk_name, word_count, found_count, rate]
  end

  def evaluations_for_each_apk
    apk_names = @evaluations.map{|row| row[0]}
    unique_apk_names = apk_names.uniq
    result = Array.new
    unique_apk_names.each do |apk_name|
      result << self.evaluate_group_by(apk_name)
    end
    return result
  end
end
