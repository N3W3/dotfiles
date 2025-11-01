;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq doom-theme 'doom-dracula)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

;; LaTeX settings
(setq +latex-viewers '(zathura))

(defun import-ical-at-start ()
  (let* ((ics-file "~/Documents/organisation/univCal.ics")
         (org-file "~/Documents/organisation/univCal.org"))
    ;; Download the .ics file
    (shell-command (concat "curl -s -o " ics-file " " my-univ-ical-url))
    ;; Convert .ics -> .org
    (shell-command (concat "icsorg -i "ics-file " -o " org-file))))

(after! latex
  ;; XeLaTeX as default
  (setq TeX-engine 'xetex
        TeX-PDF-mode t
        TeX-command-default "XeLaTeX"
        TeX-save-query nil      ;; auto-save buffers before compiling
        TeX-show-compilation nil) ;; show compilation buffer

  ;; Add XeLaTeX to command list
  (add-to-list 'TeX-command-list
               '("XeLaTeX"
                 "xelatex -interaction=nonstopmode -shell-escape %s"
                 TeX-run-TeX nil t
                 :help "Run XeLaTeX")))

;;Bindings

;; Select the treemacs window
(map! :leader
      :desc "Focus Treemacs"
      "p t" #'treemacs-select-window)

;; Configure Discord Rich Presence
;;(add-hook 'find-file-hook
;;         (lambda ()
;;            (require 'elcord nil 'noerror)
;;            (when (fboundp 'elcord-mode)
;;              (elcord-mode 1))))

(after! org
  ;; Load univ dateTime variables
  (load! "private/private.el")
  ;; Start function
  (import-ical-at-start))

(setq org-agenda-files '("~/Documents/organisation/agenda.org"
                         "~/Documents/organisation/univCal.org"))
(setq org-agenda-start-on-weekday nil) ;; Start agenda from today
(setq org-agenda-span '10) ;; Show 10 days
(setq org-agenda-show-all-dates t) ;; Show all dates

(setq tidal-boot-script-path "/usr/share/haskell-tidal/BootTidal.hs")
