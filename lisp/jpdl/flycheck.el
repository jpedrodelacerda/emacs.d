;;; flycheck.el --- Summary:

;;; Commentary:

;;; Code:

;; Checking for errors
(use-package flycheck
  :straight t
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (global-flycheck-mode))

(use-package sideline
  :straight t
  :hook ((flycheck-mode . sideline-mode))
  :init
  (setq sideline-priority 100
        sideline-display-backend-name t
        sideline-order-left 'down                    ; or 'up
        sideline-order-right 'up                     ; or 'down
        ))

(use-package sideline-flycheck
  :straight t
  :hook (flycheck-mode . sideline-flycheck-setup)
  :config
  (add-to-list sideline-backends-right 'sideline-flycheck))

(use-package sideline-eglot
  :straight (:host github :repo "emacs-sideline/sideline-eglot")
  :hook (eglot-mode . sideline-mode)
  :config
  (add-to-list sideline-backends-right 'sideline-eglot))


;; (use-package flycheck-color-mode-line
;;   :straight t
;;   :after (flycheck)
;;   :hook (flycheck-mode-hook . flycheck-color-mode-line-mode)
;;   :config
;;   (setq flycheck-color-mode-line-face-to-color 'doom-modeline))

;; (eval-after-load "flycheck"
;;   '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(provide 'jpdl/flycheck)
;;; flycheck.el ends here
