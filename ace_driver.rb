#!/usr/bin/ruby
require_relative 'apk_content_set'
require_relative 'apk_ui_content_set'
require_relative 'apk_content_evaluator'

path_content, path_ui_content, content_type, eval_type, csv_path = ARGV
acs_label = ApkContentSet.new(path_content, content_type)
aucs = ApkUIContentSet.new(path_ui_content)
ace = ApkContentEvaluator.new
ace.calc_eval(acs_label, aucs)
ace.to_csv(eval_type, csv_path)