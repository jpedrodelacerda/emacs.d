;;; font.el --- summary -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; all the icons available
(use-package all-the-icons
  :straight t)

(use-package default-text-scale
  :straight t
  :general
  ("C-)" 'default-text-scale-reset)
  ("C-+" 'default-text-scale-increase)
  ("C-_" 'default-text-scale-decrease)
  :config
  (default-text-scale-mode 1)
  (setq default-text-scale-amount 10))

;; Enable the www ligature in every possible major mode
(use-package ligature
  :straight t
  :config
  (ligature-set-ligatures 't '("www"))
  ;; Enable ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
                                       ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
                                       "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
                                       "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
                                       "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
                                       "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
                                       "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
                                       "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
                                       "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
                                       "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))
  (global-ligature-mode 't))

(provide 'jpdl/font)
;;; font.el ends here
