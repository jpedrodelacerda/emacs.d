;;;; system.el --- Summary  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'jpdl/font)

(require 'iso-transl)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))
(setq warning-minimum-level :emergency)

;; No start-up mesage
(setq inhibit-startup-message t)

(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize))

;; Remove trailing whitespace before saving file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-auto-revert-mode t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(setq use-dialog-box nil)
(setopt use-short-answers t)
(define-key minibuffer-local-completion-map (kbd "SPC") 'self-insert-command)

(use-package keychain-environment
  :straight t
  :config (keychain-refresh-environment))

(use-package use-package-chords
  :straight t
  :config (key-chord-mode 1))

(use-package auto-package-update
  :straight t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package subword
  :straight t
  :config
  (global-subword-mode))

;; Undo function
(use-package undo-fu
  :straight t)

(use-package undo-fu-session
  :straight t
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  (undo-fu-session-global-mode))

(use-package vundo
  :straight t)

(use-package which-key
  :straight t
  :config (which-key-mode))

;; No tabs
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Disable lock files
(setq create-lockfiles nil)

;; no scroll bars
(set-window-scroll-bars (minibuffer-window) nil nil)

(use-package yasnippet
  :straight t
  :custom
  (yas-snippet-dirs '("~/.emacs.d/snippets"))
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :straight t)


(use-package minions
  :straight t
  :config
  (minions-mode 1))

(use-package centered-cursor-mode
  :straight t
  :after (evil)
  :diminish centered-cursor-mode
  :commands (centered-cursor-mode
             global-centered-cursor-mode)
  :general (:states '(normal)
                    "zz" 'global-centered-cursor-mode))

(use-package rg
  :straight t)

(use-package ripgrep
  :straight t)

(use-package editorconfig
  :straight t
  :config
  (editorconfig-mode 1))

(use-package direnv
  :straight t
  :config
  (direnv-mode))

(use-package drag-stuff
  :straight t
  :general
  ("M-S-<up>" 'drag-stuff-up
   "M-S-<down>" 'drag-stuff-down)
  :config
  (drag-stuff-global-mode 1))

(use-package treesit-fold
  :straight t
  :general
  ("M-<tab>" 'treesit-fold-toggle
   "C-M-<tab>" 'treesit-fold-open-all
   "C-M-<escape>" 'treesit-fold-close-all)
  (:states '(normal)
           "zf" 'treesit-fold-toggle
           "za" 'treesit-fold-toggle
           "zo" 'treesit-fold-open
           "zq" 'treesit-fold-open-recursively
           "zO" 'treesit-fold-open-recursively
           "zc" 'treesit-fold-close
           "zM" 'treesit-fold-close-all
           "zR" 'treesit-fold-open-all))

(use-package treesit-fold-indicators
  :straight (treesit-fold-indicators :type git :host github :repo "emacs-tree-sitter/treesit-fold")
  :hook (after-init . global-treesit-fold-indicators-mode)
  :custom (treesit-fold-indicators-priority -1))

;; (use-package origami
;;   :straight (origami :type git :host github :repo "elp-revive/origami.el")
;;   :after (evil)
;;   :general
;;   ("M-<tab>" 'origami-toggle-node
;;    "C-M-<tab>" 'origami-recursively-toggle-node
;;    "C-M-<escape>" 'origami-reset)
;;   (jpdl/spc-leader
;;     "o t" 'origami-toggle-node
;;     "o a" 'origami-toggle-all-nodes
;;     "o r" 'origami-recursively-toggle-node
;;     "o z" 'origami-reset)
;;   (:states '(normal)
;;            "zq" 'origami-toggle-node
;;            "za" 'origami-toggle-all-nodes
;;            "zw" 'origami-recursively-toggle-node
;;            "zx" 'origami-reset)
;;   :config
;;   (global-origami-mode))

(use-package harpoon
  :straight t
  :after (evil)
  :general
  ("C-c a" 'harpoon-quick-menu-hydra
   "C-c h <return>" 'harpoon-add-file
   "C-c h c" 'harpoon-clear
   "C-c h h" 'harpoon-toggle-quick-menu
   "C-c h f" 'harpoon-toggle-file
   "C-c h 1" 'harpoon-go-to-1
   "C-c h 2" 'harpoon-go-to-2
   "C-c h 3" 'harpoon-go-to-3
   "C-c h 4" 'harpoon-go-to-4
   "C-c h 5" 'harpoon-go-to-5
   "C-c h 6" 'harpoon-go-to-6
   "C-c h 7" 'harpoon-go-to-7
   "C-c h 8" 'harpoon-go-to-8
   "C-c h 9" 'harpoon-go-to-9)
  (jpdl/spc-leader
    "h m" 'harpoon-quick-menu-hydra
    "h <return>" 'harpoon-toggle-quick-menu
    "h h" 'harpoon-add-file
    "h c" 'harpoon-clear
    "h f" 'harpoon-toggle-file
    "h 1" 'harpoon-go-to-1
    "h 2" 'harpoon-go-to-2
    "h 3" 'harpoon-go-to-3
    "h 4" 'harpoon-go-to-4
    "h 5" 'harpoon-go-to-5
    "h 6" 'harpoon-go-to-6
    "h 7" 'harpoon-go-to-7
    "h 8" 'harpoon-go-to-8
    "h 9" 'harpoon-go-to-9))

(use-package sops
  :straight t
  :general
  ("C-c C-c" 'sops-save-file
   "C-c C-k" 'sops-cancel
   "C-c C-d" 'sops-edit-file)
  :config
  (global-sops-mode 1))

(provide 'jpdl/system)
;;; system.el ends here
