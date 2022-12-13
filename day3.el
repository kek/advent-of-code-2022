#!/usr/bin/env -S emacs --script

(mapc (lambda (file) (load (expand-file-name file) nil t))
      '("vendor/dash.el"
        "advent-of-code.el"))
(require 'dash)

(princ "Day three\n")
(defun to-priority (char)
  (let ((a (car (string-to-list "a")))
        (A (car (string-to-list "A")))
        (z (car (string-to-list "z")))
        (Z (car (string-to-list "Z")))
        )
    (cond ((and (>= char a)
                (<= char z))
           (+ 1 (- char a)))
          ((and (>= char A)
                (<= char Z))
           (+ 27 (- char A)))
          (t (error "Out of range: %d" char)))
  ))

(defun priorities (string)
  (-map #'to-priority (string-to-list string)))

(priorities "!")

(defun convert-into-priorities (list-of-lists-of-strings)
  (->> list-of-lists-of-strings
       (--map (--map (priorities it) it))
       (--map (--map (-sort #'< it) it))
       (--map (--map (-uniq it) it))
       ))

(defun find-common (left right)
  (if (member (car left) right)
      (car left)
    (find-common (cdr left) right)))

(find-common '(potato tomato office computer) '(office yes my staple))

(defun halve-string (s)
  (let* ((sl (string-to-list s))
         (len (length sl))
         (half (/ len 2))
         (parts (-partition half sl)))
    (--map (apply #'string it) parts)))
(halve-string "heha")

(->> (read-input-skip-empty "input3.txt")
     (-map #'halve-string)
     (convert-into-priorities)
     (--map (apply #'find-common it))
     (-sum))
