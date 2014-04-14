(require 'levenshtein)

(setq ko-list (list "анархия" "анус"  "аутизм" "аутист" "биткоин"  "бнв" "борщ""быдло" "гей" "гейос" "говно" "двач" "дедфуд" "для" "дрочить" "зафорсил" "кококо крипто" "кукарек" "кун" "куркума" "ле" "линуск" "лисп" "личкрафт" "лойс" "лол" "лох" "лул" "лях" "маман" "мамка" "мюсли" "наркоман" "нассал" "обосрал" "отсос" "пидор" "поссал" "прыщи" "пук" "путин" "рак" "рашка" "свежо" "скатываешь" "скатывать" "соснул" "спайс" "среньк" "сыч" "твою" "тян" "уау" "упоротый" "упороть" "форс" "форсил" "форсить" "хаскель" "хуле" "чухан" "шиндошс" "ябл" ))

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
  (when (> (- end start) 3) ;; don't touch words widh 3 or less letters
    (let* ((cand (buffer-substring start end))
           (res (find-nearest cand)))
      (when res
        (kill-region start end)
        (insert res)))))

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
