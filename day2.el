#!/usr/bin/env -S emacs --script

(mapc (lambda (file) (load (expand-file-name file) nil t))
      '("vendor/dash.el"
        "advent-of-code.el"))
(require 'dash)

(princ "Day two\n")

;; Part One
;; A,X Rock
;; B,Y Paper
;; C,Z Scissors
(defun result (left right)
  (cond ((equal left "A")
         (cond
          ((equal right "X") 'draw)
          ((equal right "Y") 'right)
          ((equal right "Z") 'left)))
        ((equal left "B")
         (cond
          ((equal right "X") 'left)
          ((equal right "Y") 'draw)
          ((equal right "Z") 'right)))
        ((equal left "C")
         (cond
          ((equal right "X") 'right)
          ((equal right "Y") 'left)
          ((equal right "Z") 'draw)))))

(defun result-score (left right)
  (let ((r (result left right)))
    (cond ((eq r 'left) 0)
          ((eq r 'right) 6)
          (t 3))))

(defun value (pick)
  (cond
   ((equal pick "X") 1)
   ((equal pick "Y") 2)
   ((equal pick "Z") 3)))

(defun score (game)
  (let* ((left (car game))
         (right (cadr game)))
    (+ (result-score left right)
       (value right))))

(score '("A" "Y"))

(->> (read-input "input2.txt")
     (-map #'string-split)
     (--reject (equal it nil))
     (-map #'score)
     (-sum)
     (princ)
     )
