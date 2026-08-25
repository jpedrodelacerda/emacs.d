;;; treesit.el --- summary -*- lexical-binding: t -*-
;;; Commentary:

;; commentary

;;; Code:

(use-package treesit
  :straight (:type built-in)
  :commands (treesit-install-language-grammar jpdl/treesit-install-all-languages)
  :init
  (setq treesit-language-source-alist
        '((bash . ("https://github.com/tree-sitter/tree-sitter-bash"))
          (c . ("https://github.com/tree-sitter/tree-sitter-c"))
          (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp"))
          (css . ("https://github.com/tree-sitter/tree-sitter-css"))
          (d2 . ("https://github.com/ravsii/tree-sitter-d2"))
          (dart . ("https://github.com/UserNobody14/tree-sitter-dart"))
          (elisp . ("https://github.com/Wilfred/tree-sitter-elisp"))
          (elixir . ("https://github.com/elixir-lang/tree-sitter-elixir"))
          (erlang . ("https://github.com/WhatsApp/tree-sitter-erlang"))
          (gleam . ("https://github.com/gleam-lang/tree-sitter-gleam"))
          (go . ("https://github.com/tree-sitter/tree-sitter-go"))
          (hcl . ("https://github.com/tree-sitter-grammars/tree-sitter-hcl"))
          (html . ("https://github.com/tree-sitter/tree-sitter-html"))
          (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
          (json . ("https://github.com/tree-sitter/tree-sitter-json"))
          (just . ("https://github.com/IndianBoy42/tree-sitter-just"))
          (lua . ("https://github.com/Azganoth/tree-sitter-lua"))
          (make . ("https://github.com/alemuller/tree-sitter-make"))
          (markdown . ("https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown/src"))
          (markdown-inline . ("https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown-inline/src"))

          (nix . ("https://github.com/nix-community/tree-sitter-nix"))
          (nu . ("https://github.com/nushell/tree-sitter-nu"))
          ;; (ocaml . ("https://github.com/tree-sitter/tree-sitter-ocaml" "ocaml/src" "ocaml"))
          (python . ("https://github.com/tree-sitter/tree-sitter-python"))
          (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
          (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
          (ruby . ("https://github.com/tree-sitter/tree-sitter-ruby"))
          (rust . ("https://github.com/tree-sitter/tree-sitter-rust"))
          (sql . ("https://github.com/m-novikov/tree-sitter-sql"))
          (toml . ("https://github.com/tree-sitter/tree-sitter-toml"))
          (tf . ("https://github.com/tree-sitter-grammars/tree-sitter-hcl"))
          (terraform . ("https://github.com/tree-sitter-grammars/tree-sitter-hcl"))
          (tofu . ("https://github.com/tree-sitter-grammars/tree-sitter-hcl"))
          (typst . ("https://github.com/uben0/tree-sitter-typst"))
          (astro . ("https://github.com/virchau13/tree-sitter-astro"))
          (zig . ("https://github.com/GrayJack/tree-sitter-zig"))
          (yaml . ("https://github.com/ikatyang/tree-sitter-yaml"))
          ))
  :config
  (defun jpdl/treesit-install-all-languages ()
    "Install all languages specified by `treesit-language-source-alist'."
    (interactive)
    (let ((languages (mapcar 'car treesit-language-source-alist)))
      (dolist (lang languages)
        (treesit-install-language-grammar lang)
        (message "`%s' parser was installed." lang)
        (sit-for 0.75))))
  (push '(javascript-mode . js-ts-mode) major-mode-remap-alist)
  (push '(typescript-mode . typescript-ts-mode) major-mode-remap-alist)
  (push '(mermaid-mode . mermaid-ts-mode) major-mode-remap-alist)
  ;; (push '(d2-mode . d2-ts-mode) major-mode-remap-alist)
  (push '(python-mode . python-ts-mode) major-mode-remap-alist)
  (push '(c-mode . c-ts-mode) major-mode-remap-alist)
  (push '(emacs-lisp-mode . emacs-lisp-ts-mode) major-mode-remap-alist)
  (push '(markdown-mode . markdown-ts-mode) major-mode-remap-alist)
  (push '(json-mode . json-ts-mode) major-mode-remap-alist)
  (push '(yaml-mode . yaml-ts-mode) major-mode-remap-alist)
  (treesit-major-mode-setup))

(use-package treesit-fold
  :straight (treesit-fold :type git :host github :repo "emacs-tree-sitter/treesit-fold")
  :general
  ;; ("M-<tab>" 'treesit-fold-toggle
  ;;  "C-M-<tab>" 'treesit-fold-open-all
  ;;  "C-M-<escape>" 'treesit-fold-close-all)
  (:states '(normal)
           "zz" 'treesit-fold-toggle
           "za" 'treesit-fold-toggle
           "zo" 'treesit-fold-open
           "zq" 'treesit-fold-open-recursively
           "zO" 'treesit-fold-open-recursively
           "zc" 'treesit-fold-close
           "zM" 'treesit-fold-close-all
           "zR" 'treesit-fold-open-all))

(use-package treesit-fold-indicators
  :straight (treesit-fold-indicators :type git :host github :repo "emacs-tree-sitter/treesit-fold")
  :after (treesit-fold)
  :hook (after-init . global-treesit-fold-indicators-mode)
  :custom (treesit-fold-indicators-priority -1))

(provide 'jpdl/treesit)

;;; treesit.el ends here
