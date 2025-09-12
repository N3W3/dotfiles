;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq doom-theme 'doom-dracula)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

;; LaTeX settings
(setq +latex-viewers '(zathura))

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
(add-hook 'find-file-hook
          (lambda ()
            (require 'elcord nil 'noerror)
            (when (fboundp 'elcord-mode)
              (elcord-mode 1))))

