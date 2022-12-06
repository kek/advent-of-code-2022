(defun read-input (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (split-string (buffer-string) "\n")))
