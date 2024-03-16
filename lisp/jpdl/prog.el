;;; prog.el --- Summary

;;; Commentary:

;;; Code:

(require 'jpdl/utils)

(use-package treesit-auto
  :straight t
  :defer t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (let ((astro-recipe (make-treesit-auto-recipe
                       :lang 'astro
                       :ts-mode 'astro-ts-mode
                       :url "https://github.com/virchau13/tree-sitter-astro"
                       :revision "master"
                       :source-dir "src")))
    (add-to-list 'treesit-auto-recipe-list astro-recipe))
  (let ((nu-recipe (make-treesit-auto-recipe
                    :lang 'nu
                    :ts-mode 'nushell-mode
                    :url "https://github.com/nushell/tree-sitter-nu"
                    :revision "main"
                    :source-dir "src")))
    (add-to-list 'treesit-auto-recipe-list nu-recipe))
  ;; (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package hs-mode
  :straight (:type built-in)
  :defer t
  :hook (prog-mode . hs-minor-mode)
  :bind ("M-<tab>" . hs-toggle-hiding))

;; Dockerfiles
(use-package dockerfile-mode
  :straight t
  :mode "Dockerfile\\'")

;; Elixir
(use-package elixir-ts-mode
  :straight t
  :hook (elixir-ts-mode . lsp)
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
  :hook (lua-mode . lsp)
  :mode "\\.lua\\'")

;; Nix
(use-package nix-ts-mode
  :straight t
  :hook (nix-ts-mode . lsp)
  :mode "\\.nix\\'")

;; Jinja2
(use-package jinja2-mode
  :straight t
  :mode "\\.j2\\'")

;; JavaScript
(use-package js-ts-mode
  :straight (:type built-in)
  :defer t
  :hook (js-ts-mode . lsp)
  :mode ("\\.js\\'"
         "\\.mjs\\'"))

;; TypeScript
(use-package typescript-ts-mode
  :straight t
  :init
  (define-derived-mode typescript-tsx-mode typescript-mode "tsx")
  :hook ((typescript-ts-mode . lsp)
         (typescript-tsx-mode . lsp))
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . typescript-tsx-mode))
  :config
  (setq typescript-indent-level 4))
  ;; (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescript-tsx-mode)))

;; Astro
(use-package astro-ts-mode
  :straight t
  :hook (astro-ts-mode . lsp)
  :mode "\\.astro\\'")


;; =markdown=
(use-package markdown-mode
  :straight t
  :mode ("\\.md\\'"
         "\\.mdx\\'"))

(use-package grip-mode
  :straight t
  :after markdown-mode)

;; Go
;; (use-package go-ts-mode
;;   :straight (:type built-in)
(use-package go-mode
  :straight t
  :mode "\\.go\\'"
  :hook (go-ts-mode . lsp)
  :config
  ;;  Setting =\\GOPATH=
  (setenv "GOPATH" (concat home "/go"))
  (jpdl/append-to-path (concat (getenv "GOPATH") "/bin")))

;; (use-package python-ts-mode
;;   :straight (:type built-in)
(use-package python-mode
  :straight t
  :mode "\\.py\\'"
  :hook (python-ts-mode . lsp)
  :config
  (jpdl/append-to-path "~/.local/bin"))

(use-package python-black
  :straight t
  :after python-mode
  :hook (python-mode . python-black-on-save-mode))

;; TOML support.
(use-package toml-mode
  :straight t
  :mode "\\.toml\\'")

;;  =rust-mode=
(use-package rust-mode
  :straight t
  :mode "\\.rs\\'"
  :hook ((before-save-hook . rust-form)
         (rust-ts-mode . lsp))
  :init (setq rust-mode-treesitter-derive t)
  :config
  (setq rust-format-on-save t))

(use-package cargo
  :straight t
  :hook (rust-mode . cargo-minor-mode))

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
 :hook (terraform-mode . lsp)
 :config '(terraform-indent-level 4))

(use-package nushell-mode
 :straight t
 :mode "\\.nu\\'"
 :hook (nushell-mode . lsp))

;; =yaml-mode=
(use-package yaml-mode
 :straight t
 :mode ("\\.yml\\'"
        "\\.yaml\\'"))

;; sql-indent.el
(use-package sql-indent)

;; =web-mode=
(use-package web-mode
 :straight t
 :mode ("\\.eex\\'"
        "\\.gohtml\\'"
        "\\.html\\'"
        "\\.s?css\\'"
        "\\.php\\'")
 :hook (web-mode-hook . (lambda () (rainbow-mode) (setq web-mode-markup indent-offset 2))))

(use-package elm-mode
 :straight t
 :mode ("\\.elm")
 :hook (elm-mode . lsp))

(use-package yuck-mode
  :straight t
  :mode "\\.yuck\\'")

(provide 'jpdl/prog)
;;; prog.el ends here
