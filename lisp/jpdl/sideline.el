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

(use-package flymake
  :straight (:type built-in)
  :hook (prog-mode . flymake-mode)
  :general
  (jpdl/spc-leader
    "l l" 'jpdl/flymake-toggle-fancy-diagnostics)
  :config
  (defun jpdl/flymake-toggle-fancy-diagnostics ()
    "Toggle flymake fancy diagnostics"
    (interactive)
    (if flymake-show-diagnostics-at-end-of-line
        (progn (setq flymake-show-diagnostics-at-end-of-line nil)
               (flymake-mode -1)
               (flymake-mode +1)
               (print "No more fancy diagnostics!"))
      (setq flymake-show-diagnostics-at-end-of-line 'fancy)
      (flymake-mode -1)
      (flymake-mode +1)
      (print "Fancy diagnostics here we go!"))))

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
