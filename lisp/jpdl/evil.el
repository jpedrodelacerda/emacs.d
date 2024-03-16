;;; evil.el --- Summary

;;; Commentary:

;;; Code:

(use-package evil
  :straight t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (setq evil-emacs-state-mode nil)
  ;; Disable abbrev expansion when hit escape
  (define-key evil-normal-state-map (kbd "M-.") nil)
  (evil-set-undo-system 'undo-fu)
  (add-hook 'evil-insert-state-entry-hook #'jpdl/line-number-absolute)
  (add-hook 'evil-insert-state-exit-hook #'jpdl/line-number-relative)
  (setq evil-want-abbrev-expand-on-insert-exit nil)
  :bind
  (("C-s" . evil-write)
   ("C-p" . evil-jump-forward)))

(defun jpdl/line-number-relative ()
  (setq display-line-numbers 'relative))

(defun jpdl/line-number-absolute ()
  (setq display-line-numbers t))

(use-package evil-surround
  :straight t
  :config
  (global-evil-surround-mode 1))

(use-package evil-collection
  :straight t
  :after evil
  :config
  (evil-collection-init))

(use-package evil-org
  :straight t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda () (evil-org-set-key-theme)))
  (display-line-numbers-mode 1))

;; Nerd commentaries
(use-package evil-nerd-commenter
  :straight t
  :bind ("M-;" . evilnc-comment-or-uncomment-lines))

(provide 'jpdl/evil)
;;; evil.el ends here
