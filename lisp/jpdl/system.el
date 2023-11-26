;;; system.el --- Summary

;;; Commentary:

;;; Code:

(require 'jpdl/font)

(setq gc-cons-threshold 100000000)
(setq warning-minimum-level :emergency)

;; No start-up mesage
(setq inhibit-startup-message t)

;; Remove trailing whitespace before saving file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-auto-revert-mode t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package use-package-chords
 :config (key-chord-mode 1))

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package subword
  :config
  (global-subword-mode))

;; Undo function
(use-package undo-fu
  :config
  (global-unset-key (kbd "C-z"))
  :bind
  ("C-z" . undo-fu-only-undo)
  ("C-S-z" . undo-fu-only-redo)
  ("C-/" . undo-fu-only-redo))

(use-package undo-fu-session
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  (undo-fu-session-global-mode))

(use-package vundo)

(use-package which-key
  :config (which-key-mode))

;; No tabs
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Disable lock files
(setq create-lockfiles nil)

;; no scroll bars
(set-window-scroll-bars (minibuffer-window) nil nil)

(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets/text-mode"))
  (yas-global-mode 1))

(use-package yasnippet-snippets)

(use-package minions
  :config
  (minions-mode 1))

(use-package centered-cursor-mode
  :diminish centered-cursor-mode
  :commands (centered-cursor-mode
             global-centered-cursor-mode)
  ;; :hook (after-init-hook . centered-cursor-mode)
  :bind (:map evil-normal-state-map
              ("zz" . centered-cursor-mode)))
  ;; :hook (prog-mode . centered-cursor-mode))

(use-package rg)
(use-package ripgrep)

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(provide 'jpdl/system)
;;; system.el ends here
