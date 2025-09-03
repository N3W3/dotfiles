;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Load latex config 
(setq +latex-viewers '(zathura))

;; Use XeLaTeX as the default LaTeX compiler
(after! latex
  ;; Tell AUCTeX to use xelatex by default
  (setq TeX-engine 'xetex
        TeX-command-default "XeLaTeX")

  ;; Add xelatex to the command list if not already there
  (add-to-list 'TeX-command-list
               '("XeLaTeX"
                 "xelatex -interaction=nonstopmode %s"
                 TeX-run-TeX nil t
                 :help "Run XeLaTeX")))

;; Auto-compile LaTeX on save
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-hook 'after-save-hook #'TeX-command-master nil t)))
