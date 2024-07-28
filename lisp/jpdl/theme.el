;;; theme.el --- Summary

;;; Commentary:

;;; Code:
(use-package doom-themes
  :straight t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
 ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  (setq doom-themes-treemacs-theme "doom-colors")
  (setq doom-themes-variable-pitch-font (font-spec :family "Fira Code" :size 36))
  (setq doom-themes-treemacs-enable-variable-pitch nil)
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package darkman
  :straight t
  :init
  (defun disable-all-themes ()
    "disable all active themes."
    (dolist (i custom-enabled-themes)
      (disable-theme i)))

  (define-advice load-theme (:before (disable-themes-first) activate)
    (disable-all-themes))
  :config
  (setq darkman-themes '(:light doom-solarized-light :dark doom-solarized-dark))
  (darkman-mode))

(provide 'jpdl/theme)
;;; theme.el ends here
