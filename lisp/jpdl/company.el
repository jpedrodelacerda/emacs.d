;;; company.el --- Summary:

;;; Commentary:
;; Company for completion and orderless for fuzzing

;;; Code:

;; Company
(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-transformers '(company-sort-by-occurrence))
  (setq company-backends (push '(:separate company-capf company-yasnippet) company-backends))
  :bind (("C-'" . company-complete)
	 :map prog-mode-map
	 ("<tab>" . company-indent-or-complete-common)
	 :map company-active-map
	 ("DEL" . company-abort)
	 ("RET" . company-complete-selection)
	 ("<tab>" . company-complete-common-or-cycle)
	 ("<backtab>" . (lambda () (interactive) (company-complete-common-or-cycle -1)))))

;;; Fuzzing
(use-package orderless
  :after company
  :config
  (setq orderless-component-separator "[ &]"))

(provide 'jpdl/company)
;;; company.el ends here
