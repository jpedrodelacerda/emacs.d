;;; company.el --- Summary:

;;; Commentary:
;; Company for completion and orderless for fuzzing

;;; Code:

;; Company
(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (define-key company-active-map (kbd "TAB") 'company-yasnippet-or-completion)
  (setq company-transformers '(company-sort-by-occurrence))
  :bind
  ("C-'" . company-complete))

;;; Fuzzing
(use-package orderless)
(setq orderless-component-separator "[ &]")

(provide 'jpdl/company)
;;; company.el ends here
