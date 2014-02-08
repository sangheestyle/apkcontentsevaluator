#!/usr/bin/ruby
require_relative 'apk_contents_evaluator'

path_labels, path_uis = ARGV[0], ARGV[1]
ace = ApkContentsEvaluator.new(path_labels, path_uis)
ace.calc_eval()
p ace.eval_per_case
p ace.eval_per_apk
