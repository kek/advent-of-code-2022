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


(->> (read-input "input2.txt")
     (-map #'string-split)
     (--reject (equal it nil))
     (-map #'score)
     (-sum))

;; Part two

;; A,X Rock
;; B,Y Paper
;; C,Z Scissors
;; X lose
;; Y draw
;; Z win
(defun choice-for (other-choice result-needed)
  (cond
   ((equal result-needed "X") ; lose
         (cond ((equal other-choice "A") "Z")
               ((equal other-choice "B") "X")
               ((equal other-choice "C") "Y")))

   ((equal result-needed "Y") ; draw
         (cond ((equal other-choice "A") "X")
               ((equal other-choice "B") "Y")
               ((equal other-choice "C") "Z")))

   ((equal result-needed "Z") ; win
    (cond ((equal other-choice "A") "Y")
          ((equal other-choice "B") "Z")
          ((equal other-choice "C") "X")))))

(defun choose-moves (game)
  (let* ((opponent-chooses (car game))
         (result-needed (cadr game)))
    (list
     opponent-chooses
     (choice-for opponent-chooses result-needed))))

(->> (read-input "input2.txt")
     (-map #'string-split)
     (--reject (equal it nil))
     (-map #'choose-moves)
     (-map #'score)
     (-sum))
