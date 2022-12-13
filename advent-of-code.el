(defun read-input (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (split-string (buffer-string) "\n")))

(defun read-input-skip-empty (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (split-string (buffer-string) "\n" t)))
