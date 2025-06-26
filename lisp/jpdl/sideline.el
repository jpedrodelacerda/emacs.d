;;; sideline.el --- Summary:  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'use-package)

(use-package sideline
  :straight t
  :hook ((flymake-mode . sideline-mode))
  :init
  (setq sideline-priority 100
        sideline-display-backend-name t
        sideline-order-left 'down                    ; or 'up
        sideline-order-right 'up                     ; or 'down
        ))

(use-package sideline-flymake
  :straight t
  :after (sideline-mode)
  :hook (flymake-mode . sideline-mode)
  :init
  (setq sideline-flymake-display-mode 'line)
  (add-to-list sideline-backends-right 'sideline-flymake))

(use-package sideline-eglot
  :straight (:host github :repo "emacs-sideline/sideline-eglot")
  :after (sideline-mode)
  :hook (eglot-mode . sideline-mode)
  :init
  (add-to-list sideline-backends-right 'sideline-eglot))

(provide 'jpdl/sideline)
;;; sideline.el ends here
