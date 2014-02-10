apkcontentsevaluator
====================

A simple tool for evaluating match rate between labels from UI screen and contents(UI string) from apk. This tool is very simple and written by a newbie for Ruby.


##Usage##
```
$ ruby ace_driver.rb [path/to/sentence_or_lables] [path/to/ui_string] [sentence|label] [case|apk] [result_file_name]
```
###Sample command###
Get evaluation file, eval_sentence_apk.txt, using sentence files under demo directory and UI strings under demo directory.
```
$ ruby ace_driver.rb demo demo sentence apk eval_sentence_apk.txt
```

Also you can do following command for based on not apk but case. (each row of sentence file.)
```
$ ruby ace_driver.rb demo demo sentence case eval_sentence_case.txt
```

Another example for labels.
```
$ ruby ace_driver.rb demo demo label apk eval_label_apk.txt
$ ruby ace_driver.rb demo demo label case eval_label_case.txt
```
