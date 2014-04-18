(require 'levenshtein)

(setq ko-list (list "азаза" "анархия" "анон" "анус" "аутизм"  "аутист" "бан" "батхерт" "биткоин" "бнв" "бомбануло" "бомбит" "борщ" "бугурт" "будущее" "бухло" "быдло" "ветеран" "вин" "внезапно" "гей" "гейос" "говно" "двач" "дедфуд" "десу" "для" "дрочить" "ебать" "жопа" "забери" "заблевал" "задрот" "запили" "затралел" "зафорсил" "зашквареный" "збс" "итт" "кококо" "костыли" "крипто" "кукарек" "кун" "куркума" "лайк" "лалка" "ле" "лизнул" "линуск" "лисп" "личкрафт" "лойс" "лол" "лох" "лул" "лях" "маман" "мамка" "матан" "моар" "мюсли" "нано" "наркоман" "нассал" "нинужно" "ня" "обосрал" "обосрался" "отсос" "пердак" "пердолик" "петух" "петушок" "пидор" "пидорас" "пидораха" "писечка" "полизал" "полущ" "порст" "поссал" "потрачено" "ппц" "прост" "профит" "прыщи" "пук" "путин" "рабство" "разорвало" "рак" "рашка" "репост" "сасай" "свежо" "сиськи" "скатываешь" "скатывать" "слил" "соси" "сосноль" "соснул" "спайс" "спали" "спалил" "сперма" "среньк" "сыч" "твою" "тебя" "трал" "трап" "тред" "тян" "уау" "уебать" "уебать" "упоротый" "упороть" "успех" "фейл" "форс" "форсил" "форсить" "функциональщик" "хаскель" "хуйта" "хуле" "чат" "чухан" "шиндошс" "шкварить" "шлюха" "шлюха" "шлюху" "эпик" "ябл"))

(defvar *max-diff* 10)


(defvar *cons-string* "бвгджзйклмнпрстфхцчшщ")
(defvar *vowel-string* "аеёиоуыэюя")

(defun contract (word)
  "Remove all vowels and squash repetetive consonants"
  (let* ((devow-rx (format "\\([%s]*\\)" *vowel-string*))
         (squeeze-rx (format "\\([%s]\\)\\1+" *cons-string*))
         (devow (replace-regexp-in-string devow-rx "" word)))
    (replace-regexp-in-string squeeze-rx "\\1" devow)))

(defvar co-list (mapcar 'contract ko-list))
(defvar co-ko-list (mapcar* 'cons co-list ko-list))

(defun find-nearest (word)
  (setq res nil)
  (setq ldiff 1024)
  (dolist (cw co-ko-list res)
    (let ((cdiff (levenshtein-distance (contract word) (car cw))))
      (when (and (> ldiff cdiff) (< cdiff *max-diff*))
        (progn 
          (setq res (cdr cw))
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
