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

(defun convert-into-priorities (list-of-bags)
  (->> list-of-bags
       (--map (--map (priorities it) it))
       (--map (--map (-sort #'< it) it))
       (--map (--map (-uniq it) it))
       ))

(defun find-common (left right)
  (if (member (car left) right)
      (car left)
    (find-common (cdr left) right)))

; test
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

;; Part two

(defun find-common-multi (ns)
  (let ((left (car ns))
        (middle (cadr ns))
        (right (caddr ns)))
    (if (and (member (car left) middle)
             (member (car left) right))
      (car left)
      (find-common-multi (list (cdr left) middle right)))))

(->> (read-input-skip-empty "test3.txt")
     (-partition 3)
     (convert-into-priorities)
     (-map #'find-common-multi)
     (-sum))

(->> (read-input-skip-empty "input3.txt")
     (-partition 3)
     (convert-into-priorities)
     (-map #'find-common-multi)
     (-sum))
