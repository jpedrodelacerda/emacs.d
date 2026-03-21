;;; lsp.el --- Summary  -*- lexical-binding: t; -*-

;;; Commentary:
;; lsp and lsp-ui config

;;; Code:
(use-package eglot
  ;; :straight (:type built-in)
  :straight t
  :general
  (:keymaps
   "C-c f" 'eglot-format
   "C-c F" 'eglot-format-buffer
   "C-c r" 'eglot-rename
   "C-c R" 'eglot-reconnect
   "C-c a" 'eglot-code-actions
   "C-c q" 'eglot-code-action-quickfix
   "C-c o" 'eglot-code-action-organize-imports)
  (jpdl/spc-leader
    "l f" 'eglot-format
    "l F" 'eglot-format-buffer
    "l r" 'eglot-rename
    "l R" 'eglot-reconnect
    "l a" 'eglot-code-actions
    "l q" 'eglot-code-action-quickfix
    "l o" 'eglot-code-action-organize-imports)
  :custom
  (eglot-server-programs '(
                           ((python python-ts-mode) "ruff" "server")
                           ((nix-mode nix-ts-mode) "nil" :initializationOptions
                            (:formatting (:command ["alejandra"])))
                           ((jtsx-tsx-mode tsx-ts-mode)
	                        . ("rass"
		                       "--"
		                       "typescript-language-server" "--stdio"
		                       "--"
		                       "tailwindcss-language-server" "--stdio"))
                           ((js-mode js-ts-mode typescript-ts-mode typescript-mode)
                            "typescript-language-server" "--stdio" :initializationOptions)
                           ((rust-ts-mode rust-mode) "rust-analyzer"
                            :initializationOptions (:check (:command "clippy")))
                           ((c-mode c-ts-mode c++-mode c++-ts-mode objc-mode)
                            "clangd")
                           (elm-mode "elm-language-server")
                           ((go-mode go-dot-mod-mode go-dot-work-mode go-ts-mode go-mod-ts-mode
                                     go-work-ts-mode)
                            "gopls")
                           ((dart-mode dart-ts-mode) "dart" "language-server" "--client-id"
                            "emacs.eglot-dart")
                           ((elixir-mode elixir-ts-mode heex-ts-mode) "elixir-ls")
                           ((latex-mode plain-tex-mode context-mode texinfo-mode bibtex-mode
                                        tex-mode) "texlab")
                           (erlang-mode "erlang_ls" "--transport" "stdio")
                           ((yaml-ts-mode yaml-mode) "yaml-language-server" "--stdio"
                            :initializationOptions (:preferences (:documentOnTypeFormattingProvider nil)))
                           ((nix-mode nix-ts-mode) "nil")
                           ((nushell-mode nushell-ts-mode) "nu" "--lsp")
                           ((lua-mode lua-ts-mode) "lua-lsp")
                           ((terraform-mode) "tofu-ls" "serve"))
                         ((dockerfile-mode dockerfile-ts-mode) "docker-langserver" "--stdio"))
  :config
  (setq eglot-autoshutdown t
        eglot-confirm-server-initiated-edits nil))

(use-package eglot-booster
  :straight (:host github :repo "jdtsmith/eglot-booster")
  :after eglot
  :config
  (eglot-booster-mode))

(use-package xref
  :straight (:type built-in)
  :general
  (:keymaps 'evil-normal-state-map
            "gp" 'xref-go-back
            "gn" 'xref-go-forward
            "gd" 'xref-find-definitions
            "gr" 'xref-find-references)
  (jpdl/spc-leader
    "g p" 'xref-go-back
    "g n" 'xref-go-forward
    "g d" 'xref-find-definitions
    "g r" 'xref-find-references))

(use-package eldoc
  :straight (:type built-in)
  :custom
  (eldoc-echo-area-use-multiline-p nil))

(use-package eldoc-box
  :straight t
  :general
  (:keymaps
   "M-1" 'jpdl/eldoc-box-toggle)
  (jpdl/spc-leader
    "d t" 'jpdl/eldoc-box-toggle)
  :preface
  (defun jpdl/eldoc-box-visible-p ()
    "Return whether the `eldoc-box' popup is visible."
    (and eldoc-box--frame (frame-visible-p eldoc-box--frame)))

  (defun jpdl/eldoc-box-toggle ()
    "Toggle the `eldoc-box-help-at-point' popup."
    (interactive)
    (require 'eldoc-box)
    (if (jpdl/eldoc-box-visible-p)
        (eldoc-box-quit-frame)
      (eldoc-box-help-at-point)))
  :custom
  (eldoc-box-max-pixel-width 600)
  (eldoc-box-max-pixel-height 800)
  :config
  (advice-add 'keyboard-quit :before #'eldoc-box-quit-frame))

(provide 'jpdl/lsp)
;;; lsp.el ends here
