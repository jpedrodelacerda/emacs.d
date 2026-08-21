;;;; template.el --- Summary  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package yasnippet
  :straight t
  :custom
  (yas-snippet-dirs '("~/.emacs.d/snippets"))
  :config
  (yas-global-mode 1))

(use-package auto-yasnippet
  :straight t
  :after yasnippet)

(use-package laas
  :straight t
  :after yasnippet
  :hook (LaTeX-mode . laas-mode)
  :config ; do whatever here
  (aas-set-snippets 'laas-mode
                    ;; set condition!
                    :cond #'texmathp ; expand only while in math
                    "supp" "\\supp"
                    "On" "O(n)"
                    "O1" "O(1)"
                    "Olog" "O(\\log n)"
                    "Olon" "O(n \\log n)"
                    ;; bind to functions!
                    "Sum" (lambda () (interactive)
                            (yas-expand-snippet "\\sum_{$1}^{$2} $0"))
                    "Span" (lambda () (interactive)
                             (yas-expand-snippet "\\Span($1)$0"))
                    ;; add accent snippets
                    :cond #'laas-object-on-left-condition
                    "qq" (lambda () (interactive) (laas-wrap-previous-object "sqrt"))))

(provide 'jpdl/template)
;;; template.el ends here
