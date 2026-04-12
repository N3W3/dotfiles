;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq doom-theme 'doom-dracula)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

;; Load privates variables
(load! "private/private.el")


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


(after! org
  ;; Start function
  (import-ical-at-start))

(setq org-agenda-files '("~/Documents/organisation/agenda.org"
                         "~/Documents/organisation/univCal.org"))
(setq org-agenda-start-on-weekday nil) ;; Start agenda from today
(setq org-agenda-span '10) ;; Show 10 days
(setq org-agenda-show-all-dates t) ;; Show all dates

(setq tidal-boot-script-path "/usr/share/haskell-tidal/BootTidal.hs")

;; gptel config
;; Configuration du package gptel
(use-package! gptel
  :config
  ;; 1. Moteur Ollama (Local/Cloud gratuit)
  (setq gptel-ollama-backend 
        (gptel-make-ollama "Ollama"
          :host "localhost:11434"
          :stream t
          :models '("gemma4:latest")))

  ;; 2. Moteur Groq (Le "gros cerveau" 70B gratuit)
  ;; Note : On utilise gptel-make-openai car Groq est compatible avec ce format
  (setq gptel-groq-backend
        (gptel-make-openai "Groq"
          :host "api.groq.com"
          :endpoint "/openai/v1/chat/completions"
          :stream t
          :key my-groq-api-key
          :models '("llama-3.3-70b-versatile" 
                    "qwen-2.5-coder-32b"
                    "llama-3.1-8b-instant")))

  ;; On définit le modèle par défaut au démarrage
  (setq gptel-backend gptel-groq-backend
        gptel-model "llama-3.3-70b-versatile"))


;;Bindings

;; Select the treemacs window
(map! :leader
      :desc "Focus Treemacs"
      "p t" #'treemacs-select-window)

;; Keymaps (tes raccourcis sont parfaits, j'ai juste harmonisé l'alignement)
(map! :leader
      (:prefix ("l" . "ai")
       :desc "Ouvrir le chat"      "g" #'gptel
       :desc "Menu de config"      "m" #'gptel-menu
       :desc "Réécrire la région"  "r" #'gptel-rewrite
       :desc "Ajouter au contexte" "a" #'gptel-add))

