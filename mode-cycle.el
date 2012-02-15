;;; mode-cycle.el --- Buffer mode cycling for Emacs

;; Copyright (C) 2012 Dmitry Cherkassov

;; Author: Dmitry Cherkassov <dcherkassov@gmail.com>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;; Simple Buffer cycling for Emacs between buffers of current mode (default to "C-c n" and "C-c p")

;;; To use copy mode-cycle.el to your load path 
;;; and add
;;; (require 'mode-cycle)
;;; to your .emacs
;;; You may also want to redefine keybindings at the end (i define them to <- and -> in my Microsoft 4000 keyboard)

(defun get-buffer-mode (buffer-or-string)
  (save-excursion
    (set-buffer buffer-or-string)
    major-mode))

(defun get-current-mode ()
  "Returns the major mode associated with current buffer."
  (get-buffer-mode (buffer-name)))

(defun mode-cycle-to-next-buffer-help (mode)
  (progn 
    (next-buffer)
    (if (not (string= (get-current-mode) mode))
	(mode-cycle-to-next-buffer-help mode))))
	
(defun mode-cycle-to-next-buffer ()
  (interactive)
  "Switches to the next buffer of current mode."
  (mode-cycle-to-next-buffer-help (get-current-mode)))

(defun mode-cycle-to-prev-buffer-help (mode)
  (progn 
    (previous-buffer)
    (if (not (string= (get-current-mode) mode))
	(mode-cycle-to-prev-buffer-help mode))))

(defun mode-cycle-to-prev-buffer ()
  (interactive)
  "Switches to the previous buffer of current mode."
  (mode-cycle-to-prev-buffer-help (get-current-mode)))

(provide 'mode-cycle)

(global-set-key (kbd "C-c n") `mode-cycle-to-next-buffer)
(global-set-key (kbd "C-c p") `mode-cycle-to-prev-buffer)

