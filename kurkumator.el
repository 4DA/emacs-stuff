(provide 'kurkumator)

(setq ko-table ["k" "ле" "yay" "лойс" "маман" "аутист" "кукарек" "зафорсил"])

(defun make-ko-regexp (word-len sw start end)
  (let ((rx (format "\\b[[:alpha:]]\\{%d\\}\\b" word-len)))
    (replace-regexp rx sw nil start end)
    rx))

(defun kokoify (start end)
  (interactive "r")
  (save-excursion 
    (dotimes (number (length ko-table) nil) 
      (make-ko-regexp (+ 1 number) (aref ko-table number) start end))))

;; select the region and call M-x kokoify
