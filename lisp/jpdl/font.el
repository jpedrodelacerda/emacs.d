;;; font.el --- summary -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; all the icons available
(use-package all-the-icons
  :straight t)

(defun jpdl/set-fonts ()
  (interactive)
  ;; Set font based on existing ones
  ;; (cond
  ;;  ((find-font (font-spec :name "Aporetic Sans Mono"))
  ;;   (set-face-attribute 'default nil :font "Aporetic Sans Mono" :height 116 :weight 'medium)
  ;;   (set-face-attribute 'bold nil :weight 'extra-bold))
  ;;  ((find-font (font-spec :name "Hack FC Ligatured"))
  ;;   (set-face-attribute 'default nil :font "Hack FC Ligatured" :height 116)))
  (custom-set-faces
   '(tab-bar ((t (:height 0.9))))
   '(mode-line ((t (:height 0.9))))
   '(mode-line-inactive ((t (:inherit mode-line))))
   '(line-number ((t (:height 0.8 :inherit shadow))))
   '(line-number-current-line ((t (:inherit line-number))))
   '(breadcrumb-face ((t (:height 0.8))))
   '(breadcrumb-imenu-leef-face ((t (:height 1.0))))
   '(breadcrumb-project-leef-face ((t (:height 0.8))))))

;; Run on start
(add-hook 'after-init-hook #'jpdl/set-fonts)
(add-hook 'server-after-make-frame-hook #'jpdl/set-fonts)

(use-package default-text-scale
  :straight t
  :general
  ("C-)" 'default-text-scale-reset)
  ("C-+" 'default-text-scale-increase)
  ("C-_" 'default-text-scale-decrease)
  ("C-c C-=" 'global-text-scale-adjust)
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
