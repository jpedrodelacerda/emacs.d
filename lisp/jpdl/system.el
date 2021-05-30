;;; system.el --- Summary

;;; Commentary:

;;; Code:

(require 'jpdl/font)

;; Remove trailing whitespace before saving file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-auto-revert-mode t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; Undo function
(use-package undo-tree
  :config (global-undo-tree-mode)
  :bind (
         ("C-/" . undo-redo)))

(use-package which-key
  :config (which-key-mode))

;; No tabs
(setq tab-width 4)
(setq indent-tabs-mode nil)

;; no scroll bars
(set-window-scroll-bars (minibuffer-window) nil nil)

;; No start-up mesage
(setq inhibit-startup-message t)

(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets/text-mode"))
  (yas-global-mode 1))

(use-package minions
  :config
  (minions-mode 1))

(provide 'jpdl/system)
;;; system.el ends here
