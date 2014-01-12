(defun do-reply-to-post-comment ()
  (if (re-search-backward 
       "^#[0-9a-zA-Z]+\\(/[0-9a-zA-Z]+\\)?" nil t 1)
      (progn
        (end-of-buffer)
        (insert-buffer-substring-no-properties (current-buffer)
                                               (match-beginning 0) (match-end 0))
        (insert " "))
    (message "No comments found")))


(defun reply-to-post-comment()
  (interactive)

  (save-excursion
    (do-reply-to-post-comment))
  (end-of-buffer))

(global-set-key (kbd "H-R"))
