;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq doom-theme 'doom-dracula)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

;; Load privates variables
(load! "private/private.el")


;; ----- LaTeX configuration -----------------------------------
;; Set up the pdf viewer
(setq +latex-viewers '(zathura)) ;; Setup the pdf viewer

;; Run LaTeX configuration after the latex package has been loaded
(after! latex 
  ;; Set XeLaTeX as the default TeX engine
  (setq TeX-engine 'xetex 
        ;; Enable PDF mode
        TeX-PDF-mode t 
        ;; Set the default TeX command
        TeX-command-default "XeLaTeX" 
        ;; Auto-save buffers before compiling
        TeX-save-query nil      
        ;; Do not show the compilation buffer
        TeX-show-compilation nil) ;; Show compilation buffer

  ;; Add XeLaTeX to the list of available TeX commands
  (add-to-list 'TeX-command-list 
               ;; Define a new TeX command for XeLaTeX
               '("XeLaTeX" 
                 ;; Command to run XeLaTeX
                 "xelatex -interaction=nonstopmode -shell-escape %s" 
                 ;; Function to run the TeX command
                 TeX-run-TeX 
                 ;; Do not add the command to the TeX menu
                 nil 
                 ;; Add the command to the TeX menu
                 t 
                 ;; Help text for the command
                 :help "Run XeLaTeX")))

;; Xelatex compiling with shell-escape
;; Run LaTeX configuration after the latex package has been loaded
(after! latex 
  ;; Define a new compile command that includes --shell-escape
  (add-to-list 'TeX-command-list 
               ;; Define a new TeX command for XeLaTeX with shell-escape
               '("XeLaTeX-shell-escape" 
                 ;; Command to run XeLaTeX with shell-escape
                 "xelatex -shell-escape %s" 
                 ;; Function to run the TeX command
                 TeX-run-TeX 
                 ;; Do not add the command to the TeX menu
                 nil 
                 ;; Add the command to the TeX menu
                 t 
                 ;; Help text for the command
                 :help "Run XeLaTeX with --shell-escape"))
  ;; Make the XeLaTeX-shell-escape command the default
  (setq TeX-command-default "XeLaTeX-shell-escape" 
        ;; Set XeLaTeX as the default TeX engine
        TeX-engine 'xetex 
        ;; Enable PDF mode
        TeX-PDF-mode t))

;;----- Gptel package configuration -----------------------------------
(use-package! gptel
  :config
  ;; 1. Moteur Ollama (Local/Cloud gratuit)
  (setq gptel-ollama-backend 
        (gptel-make-ollama "Ollama"
          :host "localhost:11434"
          :stream t
          :models '("llama3.2:3b")))

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

;;----- Load at end -----------------------------------
(load! "map/map.el")
