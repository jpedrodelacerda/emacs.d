;;; smartparens.el --- Summary:

;;; Commentary:

;;; Code:

;; tokens beutifier and completer
(use-package smartparens
  ;; :diminish smartparens-mode
  ;; :commands smartparens-global-mode
  :bind
  ("C-SPC" . sp-forward-sexp)
  ("C-M-0" . smartparens-strict-mode)
  ;; :commands (smartparens-mode show-smartparens-mode)
  :hook ((prog-mode . smartparens-strict-mode))
  :config
  ;; (turn-on-smartparens-strict-mode)
  ;; (smartparens-global-strict-mode t)
  ;; (smartparens-global-mode 1)
  ;; (smartparens-strict-mode 1)
  ;; (setq smartparens-global-mode t)
  (show-smartparens-global-mode t)
  (require 'smartparens-config))

(provide 'jpdl/smartparens)
;;; smartparens.el ends here
