(require 'levenshtein)

(setq ko-list (list "путин" "рашка"  "пук" "свежо" "аутизм" "быдло" "говно" "скатывать" "скатываешь" "сыч" "чухан" "спайс" "куркума" "поссал" "нассал" "обосрал" "для быдла" "лох" "лол" "лул" "хуле" "лях" "мюсли" "бнв" "дедфуд" "личкрафт" "тян" "кун" "форсить" "форс" "отсос" "соснул" "гей" "прыщи"  "куркума" "твою" "анус" "ле" "yay" "лойс" "маман" "аутист" "кукарек" "зафорсил"))

(defvar *max-diff* 10)

(defun find-nearest (word)
  (setq res nil)
  (setq ldiff *max-diff*)
  (dolist (cw ko-list res)
    (let ((cdiff (levenshtein-distance word cw)))
      (when (> ldiff cdiff)
        (progn 
          (setq res cw)
          (setq ldiff cdiff))))))

(defun koko-word (start end)
  (goto-char start)
  (let* ((cand (buffer-substring start end))
         (res (find-nearest cand)))
    (when res
      (kill-region start end)
      (insert res))))

(defun kokoify (start end)
  (interactive "r")
  (save-excursion 
    (setq foundp t)
    (goto-char start)
    (while foundp
      (setq foundp 
            (re-search-forward "\\b\\([а-яА-Я]+\\)\\b" end t))
      (if foundp
          (progn
            (koko-word (match-beginning 1) (match-end 1))
            (goto-char (match-end 1)))))))

;; select the region and call M-x kokoify

(provide 'kurkumator)
