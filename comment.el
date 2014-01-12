(defvar last-comins-begin -1)
(defvar last-comins-end -1)
(defvar comment-search-count 1)

(defun is-ro-at-pt(where)
  (member 'read-only (text-properties-at where)))

(defun find-readonly-end ()
  (save-excursion
    (end-of-buffer)
    (let ((curpos (point)))
      (while (and (not (is-ro-at-pt curpos))
                  (> curpos 0))
        (setq curpos (previous-property-change curpos)))
      curpos)))

(defun do-reply-to-post-comment ()
  (if (eq last-command 'reply-to-post-comment)
      (setq comment-search-count (+ 1 comment-search-count ))
    (setq comment-search-count 1))
  
  (let ((re (find-readonly-end)))
    (if (is-ro-at-pt (point)) 
        ;; we might be on comment. jump to the next space sym
        (progn (re-search-forward "\\ ")
               (goto-char (match-beginning 0)))
      ;; start searching from editable space (to avoid counting pasted commend)
      (goto-char re))

    (if (re-search-backward 
         "^#[0-9a-zA-Z]+\\(/[0-9a-zA-Z]+\\)?" nil t comment-search-count)
        (progn
          (when (> comment-search-count 1)
            (delete-region last-comins-begin last-comins-end))
          (end-of-buffer)
          (goto-char (+ 4 re)) ;; in jabber-el editable space begins 4 symbols starting from regions border (don't know why)
          (setq last-comins-begin (point))
          (setq last-comins-end (+ 1 (point) (- (match-end 0) 
                                                (match-beginning 0))))
          (insert-buffer-substring-no-properties (current-buffer)
                                                 (match-beginning 0) 
                                                 (match-end 0))
          (insert " "))
      (message "No comments found"))))

(defun reply-to-post-comment()
  "Searches above the point for comment(post) #foo123/bar1 and places it in the beginning of editable region. Repetitive further invocations cause the inserted comment to change accordingly."
  (interactive)
  (save-excursion
    (do-reply-to-post-comment))
  (end-of-buffer))

(global-set-key (kbd "H-R"))
