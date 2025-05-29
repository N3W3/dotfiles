(after! tex
  (setq Tex-PDF-mode t
        Tex-auto-save t
        Tex-parse-self t
        TeX-view-program-selection '((output-pdf "Zathura"))))
