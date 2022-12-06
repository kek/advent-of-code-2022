#!/usr/bin/env -S emacs --script

(mapc (lambda (file) (load (expand-file-name file) nil t))
 '("vendor/dash.el"
   "advent-of-code.el"))
(require 'dash)

(princ "Day one\n")

;; Part One
(->> (read-input "input1.txt")
     (-partition-after-pred #'string-empty-p)
     (--map (-map #'string-to-number it))
     (-map #'-sum)
     (-max)
     (format "Biggest bag of calories: %d\n")
     (princ))

;; Part Two
(->> (read-input "input1.txt")
     (-partition-after-pred #'string-empty-p)
     (--map (-map #'string-to-number it))
     (-map #'-sum)
     (-sort #'>)
     (-take 3)
     (-sum)
     (format "Sum of three biggest bags: %d\n")
     (princ))
