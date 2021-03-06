;;; prog.el --- Summary

;;; Commentary:

;;; Code:

(require 'jpdl/utils)
;; Ansible
(use-package ansible
  :after (yaml-mode)
  :mode ("\\.yml\\'"
         "\\.yaml\\'"))

(use-package company-ansible
  :after
  (company)
  :mode ("\\.yml\\'"
         "\\.yaml\\'")
  :config (add-to-list 'company-backends 'company-ansible))

;; API Blueprint
(use-package apib-mode
  :mode "\\.apib\\'")

;; Dockerfiles
(use-package dockerfile-mode
  :mode "Dockerfile$")

;; Elixir
(use-package elixir-mode
  :mode ("\\.exs\\'"
         "\\.ex\\'")
  )

(use-package alchemist
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
    "C-c a f"   "info")
  )

;; Lua
(use-package lua-mode
  :mode "\\.lua\\'")

;; Jinja2
(use-package jinja2-mode
  :mode "\\.j2\\'")

;; JavaScript
(use-package js2-mode
  :mode "\\.js\\'")

;; =markdown=
(use-package markdown-mode
  :mode "\\.md\\'")

(use-package grip-mode
  :after markdown-mode)

;; Go
(use-package go-mode
  :mode "\\.go\\'"
  :config
  ;;  Setting =$GOPATH=
  (setenv "GOPATH" (concat home "/go"))
  (jpdl/append-to-path (concat (getenv "GOPATH") "/bin")))

(use-package python-mode
  :config
  (jpdl/append-to-path "~/.local/bin"))

(use-package elpy
  :config
  (elpy-enable))

(use-package company-anaconda
  :after company
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode))

(use-package company-anaconda
  :after company
  :config
  (add-to-list 'company-backends 'company-anaconda))

;; TOML support.
(use-package toml-mode
  :mode "\\.toml\\'")


;;  =rust-mode=
(use-package rust-mode
  :mode "\\.rs\\'"
  :config
  (setq rust-format-on-save t))

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(use-package flycheck-rust
  :hook (flycheck-mode . flycheck-rust-setup))

;; sh
(add-hook 'sh-mode-hook
          (lambda ()
            (setq sh-basic-offset 2
                  sh-indentation 2)))

;; Terraform
(use-package terraform-mode
  :config '(terraform-indent-level 4)
  :mode ("\\.tf$"
         "\\.tfvars$"
         "\\.tfstate$"))

(use-package company-terraform
  :after (company terraform-mode)
  :config (company-terraform-init))

;; =yaml-mode=
(use-package yaml-mode
  :mode ("\\.yml\\'"
         "\\.yaml\\'"))


;; =web-mode=
(use-package web-mode
  :mode ("\\.eex$"
	 "\\.gohtml$"
	 "\\.html$"
	 "\\.php$"))

(add-hook 'web-mode-hook
          (lambda ()
            (rainbow-mode)
            (setq web-mode-markup-indent-offset 2)))

;; =emmet-mode=
(use-package emmet-mode
  :mode ("\\.gohtml$"
	 "\\.html$"
	 "\\.php$"))


(use-package company-web
  :mode ("\\.gohtml$"
	 "\\.html$"
	 "\\.php$"))

(provide 'jpdl/prog)
;;; prog.el ends here
