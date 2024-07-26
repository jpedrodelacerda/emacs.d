;;; company.el --- Summary:

;;; Commentary:
;; Company for completion and orderless for fuzzing

;;; Code:

;; Company
(use-package company
  :straight t
  :hook (after-init . global-company-mode)
  :general
  ("C-`" 'company-complete)
  (:keymaps 'company-active-map
	        "DEL" 'company-abort
            "C-y" 'company-complete-selection
	        ;; "RET" . company-complete-selection
	        "<tab>" 'company-complete-common-or-cycle
            "<backtab>" '((lambda) (interactive) company-complete-common-or-cycle -1))
  :config
  (setq company-transformers '(company-sort-by-occurrence))
  (setq company-backends (push '(:separate company-capf company-yasnippet) company-backends))
  (setq company-minimum-prefix-length 2))

;;; Fuzzing
(use-package orderless
  :straight t
  :after company
  :config
  (setq orderless-component-separator "[ &]"))

;; (use-package company-box
;;   :hook (company-mode . company-box-mode))

(provide 'jpdl/company)
;;; company.el ends here
