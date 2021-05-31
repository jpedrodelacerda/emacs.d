;;; ux.el --- Summary

;;; Commentary:

;;; Code:

;; Themes
;; all the icons available
(use-package all-the-icons)

;; Doom-modeline
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :custom-face
  (doom-modeline-evil-emacs-state ((t (:inherit bold :foreground "dark magenta"))))
  (doom-modeline-evil-insert-state ((t (:inherit bold :foreground "deep sky blue"))))
  :config
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-lsp t)
  (setq doom-modeline-modal-icon t)
  (setq doom-modeline-vcs-icon t)
  (setq find-file-visit-truename t)
  (setq doom-modeline-project-detection 'project)
  (setq doom-modeline-vcs-max-length 12)
  (setq doom-modeline-icon (display-graphic-p))
  (setq doom-modeline-minor-modes (featurep 'minions)))

(use-package solaire-mode
  :config (solaire-global-mode +1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'jpdl/ux)
;;; ux.el ends here
