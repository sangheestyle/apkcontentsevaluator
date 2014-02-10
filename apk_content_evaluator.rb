#!/usr/bin/ruby
require 'csv'
require_relative 'apk_ui_content_set'
require_relative 'apk_label_set'

class ApkContentEvaluator
  attr_reader :eval_per_case, :eval_per_apk

  def initialize(path_labels, path_ui_contents)
    als = ApkLabelSet.new(path_labels)
    aucs = ApkUIContentSet.new(path_ui_contents)
    @apk_label_set = als.apk_label_set
    @apk_ui_content_set = aucs.apk_ui_content_set
    @eval_per_case = Array.new
    @eval_per_apk = Array.new
  end

  def calc_eval()
    @apk_label_set.each do |label|
      @eval_per_case << calc_eval_per_case(label, @apk_ui_content_set)
    end
    apk_names = @eval_per_case.map{|row| row[0]}
    unique_apk_names = apk_names.uniq
    unique_apk_names.each do |apk_name|
      @eval_per_apk << calc_eval_per_apk(apk_name)
    end
  end

  def calc_eval_per_case(label, ui_content_set)
    ui_contents = ui_content_set.detect{|uc| uc.apk_name == label.apk_name}
    words = label.labels
    found_count = 0
    words.each do |word|
      if ui_contents.content.scan(word)
        found_count += 1
      end
    end
    rate = Float(words.count) / Float(found_count) * 100
    return [label.apk_name, label.id, words.count, found_count, rate]
  end

  def calc_eval_per_apk(apk_name)
    rows = @eval_per_case.find_all{|row| row[0] == apk_name}
    word_count = 0
    found_count = 0
    rows.each do |row|
      word_count += row[2]
      found_count += row[3]
    end
    rate = Float(word_count) / Float(found_count) * 100
    return [apk_name, word_count, found_count, rate]
  end

  def to_csv(type="case", path)
    CSV.open(path, "wb") do |csv|
      case type
      when "case"
        @eval_per_case.each {|row| csv << row}
      when "apk"
        @eval_per_apk.each {|row| csv << row}
      end
    end
  end

  private :calc_eval_per_case, :calc_eval_per_apk

end
