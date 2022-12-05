(setq filename "input1.txt")
(with-temp-buffer
  (insert-file-contents filename)
  (let* ((food-item-strings (split-string (buffer-string) "\n"))
         (bags-of-strings (-partition-after-pred #'string-empty-p food-item-strings))
         (bags-of-numbers (mapcar (lambda (item) (mapcar #'string-to-number item)) bags-of-strings))
         (bag-calories (mapcar #'-sum bags-of-numbers))
         (max-bag-calories (-max bag-calories)))
    max-bag-calories))
