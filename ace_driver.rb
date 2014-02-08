#!/usr/bin/ruby
require_relative 'apk_contents_evaluator'

path_labels, path_uis, eval_type, csv_path = ARGV
ace = ApkContentsEvaluator.new(path_labels, path_uis)
ace.calc_eval()
ace.to_csv(eval_type, csv_path)
