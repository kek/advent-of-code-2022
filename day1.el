;; Part One
(with-temp-buffer
  (insert-file-contents "input1.txt")
  (->> (buffer-string)
       (funcall (-flip #'split-string) "\n")
       (-partition-after-pred #'string-empty-p)
       (--map (-map #'string-to-number it))
       (-map #'-sum)
       (-max)))

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
       (-sum)))
