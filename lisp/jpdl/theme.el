;;; theme.el --- Summary

;;; Commentary:

;;; Code:

(use-package doom-themes
  :straight t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; (load-theme 'doom-ayu-dark)
   ;; (load-theme 'doom-solarized-light t)

  ;; (load-theme 'doom-homage-black)

 ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  (setq doom-themes-treemacs-theme "doom-colors")
  (setq doom-themes-variable-pitch-font (font-spec :family "Fira Code" :size 36))
  (setq doom-themes-treemacs-enable-variable-pitch nil)
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package circadian
  :straight t
  :after doom-themes
  :config
  (setq circadian-themes '(("8:00" . doom-solarized-light)
                           ("18:00" . doom-solarized-dark)))
  (circadian-setup))

;; (use-package auto-dark
;;   :straight t
;;   :after doom-themes
;;   :config
;;   (setq auto-dark-dark-theme 'doom-ayu-dark)
;;   (setq auto-dark-light-theme 'doom-solarized-light)
;;   (auto-dark-mode t))

;;(use-package modus-themes
;;  :config
;;  (load-theme 'modus-vivendi-tritanopia))

;;(use-package catppuccin-theme
;;  :config
;;  (setq catppucin-flavor 'mocha)
;;  (load-theme 'catppuccin :no-confirm))

(provide 'jpdl/theme)
;;; theme.el ends here
