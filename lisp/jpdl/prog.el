;;; prog.el --- Summary  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'jpdl/utils)

(use-package typst-ts-mode
  :straight (:host sourcehut :repo "meow_king/typst-ts-mode")
  :mode ("\\.typ\\'" . typst-ts-mode)
  :general
  (jpdl/spc-leader :keymaps '(typst-ts-mode-map)
    "t c" 'typst-ts-compile)
  :custom
  (typst-ts-mode-watch-options "--open")
  :config
  (add-to-list 'lsp-language-id-configuration '(typst-ts-mode . "tinymist"))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "tinymist")
    :major-modes '(typst-ts-mode)
    :server-id 'tinymist)))

(use-package websocket
  :straight t)

(use-package typst-preview
  :straight (:host github :repo "havarddj/typst-preview.el")
  :general
  (jpdl/spc-leader :keymaps '(typst-ts-mode)
    "t p" 'typst-preview-mode
    "t j" 'typst-preview-send-position
    "t r" 'typst-preview-restart)
  :config
  (setq typst-preview-executable "tinymist preview")
  (setq typst-preview-browser "default"))

(use-package mermaid-mode
  :straight t
  :mode "\\.mmd\\'")

;; Dockerfiles
(use-package dockerfile-mode
  :straight t
  :mode "Dockerfile\\'")

;; Elixir
(use-package elixir-ts-mode
  :straight t
  :hook (elixir-ts-mode . eglot-ensure)
  :mode ("\\.exs\\'"
         "\\.ex\\'"))

(use-package alchemist
  :straight t
  :after (elixir-mode which-key)
  :config
  (which-key-add-major-mode-key-based-replacements 'elixir-mode
    "C-c a"     "alchemist"
    "C-c a m"   "mix"
    "C-c a m t" "mix-test"
    "C-c a X"   "hex"
    "C-c a c"   "compile"
    "C-c a e"   "execute"
    "C-c a p"   "project"
    "C-c a n"   "phoenix"
    "C-c a h"   "help"
    "C-c a i"   "iex"
    "C-c a v"   "eval"
    "C-c a o"   "macroexpand"
    "C-c a f"   "info"))

;; Lua
(use-package lua-mode
  :straight t
  :hook (lua-mode . eglot-ensure)
  :mode "\\.lua\\'")

;; Nix
(use-package nix-mode
  :straight t
  :hook (nix-mode . eglot-ensure)
  :mode "\\.nix\\'"
  :config
  (add-to-list 'eglot-server-programs
               '((nix-mode nix-ts-mode) . ("nil" :initializationOptions
                                           (:formatting (:command ["alejandra"]))))))

(use-package nix-ts-mode
  :straight t
  :hook (nix-ts-mode . eglot-ensure)
  :mode "\\.nix\\'")

(use-package nix-update
  :straight t
  :general ("C-c C-n u" 'nix-update-fetch))

;; Jinja2
(use-package jinja2-mode
  :straight t
  :mode "\\.j2\\'")

;; JavaScript
(use-package js-ts-mode
  :straight (:type built-in)
  :defer t
  :hook (js-ts-mode . eglot-ensure)
  :mode ("\\.js\\'"
         "\\.mjs\\'"))

;; TypeScript
(use-package typescript-ts-mode
  :straight (:type built-in)
  :hook
  (typescript-ts-mode . eglot-ensure)
  (tsx-ts-mode . eglot-ensure)
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . tsx-ts-mode)))

;; Astro
(use-package astro-ts-mode
  :straight t
  :after (treesit)
  :hook (astro-ts-mode . eglot-ensure)
  :mode "\\.astro\\'")

;; =markdown=
(use-package markdown-mode
  :straight t
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.mdx\\'" . markdown-mode))
  :custom
  (markdown-command '("pandoc" "--from=markdown" "--to=html5")))

(use-package markdown-toc
  :straight (:host github :repo "jpedrodelacerda/markdown-toc")
  :general
  (:keymaps '(markdown-ts-mode-map markdown-mode-map)
            "C-c m t" 'markdown-toc-generate-or-refresh-toc)
  (jpdl/spc-leader :keymaps '(markdown-ts-mode-map markdown-mode-map)
    "mt" 'markdown-toc-generate-or-refresh-toc))

(use-package grip-mode
  :straight t
  :custom
  (gripq-command 'go-grip)
  (grip-preview-use-webkit t)
  :general
  (:keymaps '(markdown-ts-mode-map markdown-mode-map)
            "C-c m g" 'grip-mode)
  (jpdl/spc-leader :keymaps '(markdown-ts-mode-map markdown-mode-map)
    "mg" 'grip-mode))

;; Go
;; (use-package go-ts-mode
;;   :straight (:type built-in)
(use-package go-mode
  :straight t
  :mode "\\.go\\'"
  :hook (go-ts-mode . eglot-ensure)
  :config
  ;;  Setting =\\GOPATH=
  (setenv "GOPATH" (concat home "/go"))
  (jpdl/append-to-path (concat (getenv "GOPATH") "/bin")))

;; (use-package python-ts-mode
;;   :straight (:type built-in)
(use-package python-mode
  :straight t
  :mode "\\.py\\'"
  :hook (python-ts-mode . eglot-ensure)
  :config
  (jpdl/append-to-path "~/.local/bin")
  (add-to-list 'eglot-server-programs
               '((python python-ts-mode) . ("ruff" "server"))))

(use-package python-black
  :straight t
  :after python-mode
  :hook (python-mode . python-black-on-save-mode))

;; TOML support.
;; (use-package toml-mode
;;   :straight t
;;   :mode "\\.toml\\'")

(use-package toml-ts-mode
  :straight (:type built-in)
  :mode "\\.toml\\'")

;;  =rust-mode=
(use-package rust-mode
  :straight t
  :mode "\\.rs\\'"
  :hook (rust-ts-mode . eglot-ensure)
  :init (setq rust-mode-treesitter-derive t))

(use-package cargo
  :straight t
  :hook (rust-ts-mode . cargo-minor-mode))

(use-package flycheck-rust
  :straight t
  :hook (flycheck-mode . flycheck-rust-setup))

;; sh
(add-hook 'sh-mode-hook
          (lambda ()
            (setq sh-basic-offset 2
                  sh-indentation 2)))

;; Terraform
(use-package terraform-mode
  :straight t
  :mode ("\\.tf\\'"
         "\\.tfvars\\'"
         "\\.tfstate\\'")
  :hook (terraform-mode . eglot-ensure)
  :config '(terraform-indent-level 4))

(use-package nushell-mode
  :straight t
  :mode "\\.nu\\'"
  :hook (nushell-mode . eglot-ensure))

;; =yaml-mode=
(use-package yaml-ts-mode
  :straight (:type built-in)
  :hook (yaml-ts-mode . eglot-ensure)
  :mode ("\\.yml\\'"
         "\\.yaml\\'"))

(use-package yaml-pro
  :straight t
  :after (yaml-ts-mode)
  :hook (yaml-ts-mode . yaml-pro-ts-mode)
  :general
  (:keymaps 'yaml-pro-ts-mode-map
            "C-c C-f" 'yaml-pro-format-ts)
  (jpdl/spc-leader :keymaps 'yaml-pro-ts-mode-map
    "ff" 'yaml-pro-format-ts))

;; sql-indent.el
(use-package sql-indent
  :straight t)

;; =web-mode=
(use-package web-mode
  :straight t
  :mode ("\\.eex\\'"
         "\\.gohtml\\'"
         "\\.html\\'"
         "\\.s?css\\'"
         "\\.php\\'")
  :hook (web-mode-hook . (lambda () (rainbow-mode) (setq web-mode-markup indent-offset 2))))

(use-package rainbow-mode
  :straight t
  :hook (prog-mode . rainbow-mode))

(use-package elm-mode
  :straight t
  :mode ("\\.elm")
  :hook (elm-mode . eglot-ensure))

(use-package gren-mode
  :straight (:host github :repo "MaeBrooks/gren-mode")
  :mode ("\\.gren\\'" . gren-ts-mode))

(use-package yuck-mode
  :straight t
  :mode "\\.yuck\\'")

(use-package dart-mode
  :straight t
  :mode ("\\.dart\\'")
  :hook
  (dart-mode . eglot-ensure)
  :config
  (add-hook 'eglot-managed-mode-hook (lambda ()
                                       (eglot-inlay-hints-mode -1)
                                       (run-at-time 1 nil (lambda () (eglot-inlay-hints-mode 1))))))

(use-package flutter
  :straight t
  :after dart-mode
  :hook
  (dart-mode . flutter-test-mode)
  :general
  (:keymaps 'dart-mode-map
            "C-M-x" 'flutter-run-or-hot-reload)
  (jpdl/spc-leader :keymaps '(dart-mode-map)
    "f r" 'flutter-run-or-hot-reload
    "f t" 'flutter-test-all
    "f p" 'flutter-test-at-point))

(use-package just-ts-mode
  :straight t
  :mode ("\\justfile\\'"))

(use-package emacs-lisp-ts-mode
  :straight (:host github :repo "gabrielfrigo4/emacs-lisp-ts-mode"))

(provide 'jpdl/prog)
;;; prog.el ends here
