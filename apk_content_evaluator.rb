#!/usr/bin/ruby
require 'csv'

class ApkContentEvaluator
  attr_reader :eval_per_case, :eval_per_apk

  def initialize()
    @eval_per_case = Array.new
    @eval_per_apk = Array.new
  end

  def calc_eval(apk_content_set, apk_ui_content_set)
    apk_content_set.content_set.each do |apk_content|
      @eval_per_case << calc_eval_per_case(apk_content,
                                           apk_ui_content_set.content_set)
    end
    apk_names = @eval_per_case.map{|row| row[0]}
    unique_apk_names = apk_names.uniq
    unique_apk_names.each do |apk_name|
      @eval_per_apk << calc_eval_per_apk(apk_name)
    end
  end

  def calc_eval_per_case(apk_content, ui_content_set)
    content = apk_content.content
    ui_content = ui_content_set.detect{|uc| uc.name == apk_content.name}
    if ui_content.class == NilClass
      raise "#{apk_content.name} is not in UI content set."
    end
    found_count = 0
    content.each do |item|
      if ui_content.content.scan(item)
        found_count += 1
      end
    end
    rate = Float(content.count) / Float(found_count) * 100
    evaluation = [apk_content.name, apk_content.id, content.count, found_count, rate]
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
    evaluation = [apk_name, word_count, found_count, rate]
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
