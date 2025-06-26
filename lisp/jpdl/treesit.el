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
          (dart . ("https://github.com/UserNobody14/tree-sitter-dart"))
          (elisp . ("https://github.com/Wilfred/tree-sitter-elisp"))
          (elixir . ("https://github.com/elixir-lang/tree-sitter-elixir"))
          (erlang . ("https://github.com/WhatsApp/tree-sitter-erlang"))
          (go . ("https://github.com/tree-sitter/tree-sitter-go"))
          (html . ("https://github.com/tree-sitter/tree-sitter-html"))
          (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
          (json . ("https://github.com/tree-sitter/tree-sitter-json"))
          (lua . ("https://github.com/Azganoth/tree-sitter-lua"))
          (make . ("https://github.com/alemuller/tree-sitter-make"))
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
  (push '(python-mode . python-ts-mode) major-mode-remap-alist)
  (push '(c-mode . c-ts-mode) major-mode-remap-alist)
  (push '(json-mode . json-ts-mode) major-mode-remap-alist)
  (push '(yaml-mode . yaml-ts-mode) major-mode-remap-alist)
  (treesit-major-mode-setup))

(provide 'jpdl/treesit)

;;; treesit.el ends here
