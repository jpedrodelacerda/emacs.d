;;; evil.el --- Summary

;;; Commentary:

;;; Code:

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (setq evil-emacs-state-mode nil)
  ;; Disable abbrev expansion when hit escape
  (define-key evil-normal-state-map (kbd "M-.") nil)
  (setq evil-want-abbrev-expand-on-insert-exit nil)
  :bind
  ("C-s" . evil-write))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda () (evil-org-set-key-theme))))

;; Nerd commentaries
(use-package evil-nerd-commenter
  :bind ("M-;" . evilnc-comment-or-uncomment-lines))

(use-package nlinum)

(use-package nlinum-relative
  :after (nlinum evil)
  :config
  (global-nlinum-relative-mode)
  (nlinum-relative-setup-evil))

(provide 'jpdl/evil)
;;; evil.el ends here
