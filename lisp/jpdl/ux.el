;;; ux.el --- Summary  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; Themes
(use-package emojify
  :straight t
  :hook
  (eww-mode . emojify-mode)
  (org-mode . emojify-mode)
  (markdown-mode . emojify-mode))

;; Doom-modeline
(use-package doom-modeline
  :straight t
  :hook (after-init . doom-modeline-mode)
  :custom-face
  (doom-modeline-evil-emacs-state ((t (:inherit bold :foreground "dark magenta"))))
  (doom-modeline-evil-insert-state ((t (:inherit bold :foreground "deep sky blue"))))
  :config
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-lsp t)
  (setq doom-modeline-position-column-line-format '("[%l:%c]"))
  (setq doom-modeline-modal-icon t)
  (setq doom-modeline-vcs-icon t)
  ;; (setq find-file-visit-truename t)
  (setq doom-modeline-project-detection 'project)
  (setq doom-modeline-persp-name t)
  (setq doom-modeline-persp-icon t)
  (setq doom-modeline-height 25)
  (setq doom-modeline-width 4)
  (setq doom-modeline-hud t)
  (setq doom-modeline-vcs-max-length 12)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-icon (display-graphic-p))
  (setq doom-modeline-minor-modes (featurep 'minions)))

(use-package solaire-mode
  :straight t
  :config (solaire-global-mode +1))

(use-package display-line-numbers
  :straight (:type built-in)
  :hook (prog-mode . display-line-numbers-mode))

;; (use-package dimmer
;; :straight t
;; :config
;; (setq dimmer-fraction           0.1
;; dimmer-adjustment-mode    :both)
;; (dimmer-mode t))

(use-package rainbow-delimiters
  :straight t
  :init
  (defun jpdl/rainbow-delimiters-mode ()
    (when (not (derived-mode-p 'tsx-ts-mode))
      (rainbow-delimiters-mode)))
  :hook
  (prog-mode . jpdl/rainbow-delimiters-mode))

(use-package prism
  :straight t)
(use-package hl-todo
  :straight t
  :after (org-mode)
  :hook ((prog-mode . hl-todo-mode) (org-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"        warning bold)
          ("FIXME"       error bold)
          ("HACK"        font-lock-constant-face bold)
          ("REVIEW"      font-lock-keyword-face bold)
          ("NOTE"        success bold)
          ("DEPRECATED"  font-lock-doc-face bold))))

(use-package highlight-indentation
  :straight t
  :general
  ("C-c i" 'highlight-indentation-mode))

(use-package beacon
  :straight t
  :custom
  (beacon-color "#666600")
  (beacon-blink-duration 0.01)
  :config
  (beacon-mode 1))


(provide 'jpdl/ux)
;;; ux.el ends here
