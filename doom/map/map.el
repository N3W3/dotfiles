;;-----Bindings------------------------------

(map! :leader
      :desc "Focus Treemacs"
      "p t" #'treemacs-select-window)

(map! :leader
      (:prefix ("l" . "ai")
       :desc "Ouvrir le chat"      "g" #'gptel
       :desc "Menu de config"      "m" #'gptel-menu
       :desc "Réécrire la région"  "r" #'gptel-rewrite
       :desc "Ajouter au contexte" "a" #'gptel-add))

