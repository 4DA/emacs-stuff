(require 'cl)

(defun get-buf-dirs ()
  (mapconcat 'identity
	     (delete-dups
	      (reduce (lambda (lst b)
			(append lst
				(list (file-name-directory
				       (or (buffer-file-name b) "")) '())))
		      (buffer-list)
		      :initial-value '()))
	     " "))

(defun find-grep/dirs (what)
  (interactive "SWhat: ")
  (find-grep (format "find %s -type f -exec grep -nH -e %s {} +" (get-buf-dirs) what)))

(provide 'find-grep-dirs)
