;;; mode-cycle.el --- Buffer mode cycling for Emacs
;;; version 0.1

;; Copyright (C) 2013 Dmitry Cherkassov

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
;;; int array []
;;;            ^
;;;            |
;;;            + - Pressing M-h here kills ``array'' as well
;;;
;;; If you dislike such behaviour theese two functions make help you
;;;
;;; To use copy mode-cycle.el to your load path 
;;; and add
;;; (require 'smart-kill)
;;; to your .emacs
;;; And use global-set-key to bind them (to M-d and M-h for example)

(defun backward-kill-word-or-delim ()
  "Deletes a word or delimiter/punctuation symbol backwards"
(interactive)
(push-mark (point))

(skip-syntax-backward "-_>")

(when (= 0 (skip-syntax-backward "w\""))
    (skip-syntax-backward "_.'()(])[$"))

(kill-region (point) (mark))
(pop-mark))


(defun forward-kill-word-or-delim ()
  "Deletes a word or delimiter/punctuation symbol forward"
(interactive)
(push-mark (point))

(skip-syntax-forward "-_>")

(when (= 0 (skip-syntax-forward "w\""))
    (skip-syntax-forward "_.'()(])[$"))

(kill-region (point) (mark))
(pop-mark))

(provides 'smart-kill)

