#!/usr/bin/env -S emacs --script

(load (expand-file-name "vendor/dash.el") nil t)
(require 'dash)

(princ "Day one\n")

;; Part One
(with-temp-buffer
  (insert-file-contents "input1.txt")
  (->> (buffer-string)
       (funcall (-flip #'split-string) "\n")
       (-partition-after-pred #'string-empty-p)
       (--map (-map #'string-to-number it))
       (-map #'-sum)
       (-max)
       (format "Biggest bag of calories: %d\n")
       (princ)))

;; Part Two
(with-temp-buffer
  (insert-file-contents "input1.txt")
  (->> (buffer-string)
       (funcall (-flip #'split-string) "\n")
       (-partition-after-pred #'string-empty-p)
       (--map (-map #'string-to-number it))
       (-map #'-sum)
       (-sort #'>)
       (-take 3)
       (-sum)
       (format "Sum of three biggest bags: %d\n")
       (princ)))
