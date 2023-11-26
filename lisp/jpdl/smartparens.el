;;; smartparens.el --- Summary:

;;; Commentary:

;;; Code:

;; tokens beutifier and completer
(use-package smartparens
  :bind
  ("C-SPC" . sp-forward-sexp)
  ("C-M-0" . smartparens-strict-mode)
  :hook ((after-init . smartparens-global-strict-mode) (prog-mode . smartparens-mode))
  :config
  (setq)
  (show-smartparens-global-mode t)
  (require 'smartparens-config))

(provide 'jpdl/smartparens)
;;; smartparens.el ends here
