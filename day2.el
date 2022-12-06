#!/usr/bin/env -S emacs --script

(mapc (lambda (file) (load (expand-file-name file) nil t))
      '("vendor/dash.el"
        "advent-of-code.el"))
(require 'dash)

(princ "Day two\n")

;; Part One
(->> (read-input "input2.txt")
     (-take 1)
     (format "Something: %s\n")
     (princ))
