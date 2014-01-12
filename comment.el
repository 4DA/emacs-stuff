(defvar last-comins-begin -1)
(defvar last-comins-end -1)

(defun find-readonly-end ()
  (let ((curpos (point)))
    (while (and (not (member 'read-only 
                             (text-properties-at curpos)))
                (> curpos 0))
      (setq curpos (previous-property-change curpos)))
    curpos))

(defun do-reply-to-post-comment ()
  (if (re-search-backward 
       "^#[0-9a-zA-Z]+\\(/[0-9a-zA-Z]+\\)?" nil t 1)
      (progn
        (end-of-buffer)
        (goto-char (+ 4 (find-readonly-end)))
        (setq last-comins-begin (point))
        (setq last-comins-end (+ (point) (- (match-end 0) (match-beginning 0))))
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
