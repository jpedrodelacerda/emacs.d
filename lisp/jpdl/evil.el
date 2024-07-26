;;; evil.el --- Summary

;;; Commentary:

;;; Code:

(use-package evil
  :straight t
  :init
  (setq evil-want-keybinding nil)
  :general
  ("C-s" 'evil-write)
  ("C-o" 'evil-jump-backward)
  ("C-p" 'evil-jump-forward)
  ;; :hook ((evil-insert-state-entry . #'jpdl/line-number-absolute)
  ;;        (evil-insert-state-exit . #'jpdl/line-number-relative))
  :config
  (evil-mode 1)
  (setq evil-emacs-state-mode nil)
  ;; Disable abbrev expansion when hit escape
  (general-def :states '(normal motion insert) "M-." 'nil)
  (general-def :states '(normal motion insert) "C-o" 'nil)
  (general-def :states '(normal insert) "C-p" 'nil)
  (evil-set-undo-system 'undo-fu)
  (add-hook 'evil-insert-state-entry-hook #'jpdl/line-number-absolute)
  (add-hook 'evil-insert-state-exit-hook #'jpdl/line-number-relative)
  (setq evil-want-abbrev-expand-on-insert-exit nil))

(defun jpdl/bad-archer ()
  (interactive)
  (message "You have ran out of arrows!"))

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
  :hook ((org-mode . evil-org-mode)
         (evil-org-mode . evil-org-set-key-theme)
         (org-agenda-mode . evil-org-agenda-set-keys))
  :config
  (require 'evil-org-agenda)
  ;; (evil-org-agenda-set-keys)
  (display-line-numbers-mode 1))

;; Nerd commentaries
(use-package evil-nerd-commenter
  :straight t
  :general ("M-;" 'evilnc-comment-or-uncomment-lines))

(use-package evil-matchit
  :straight t
  :after evil
  :config
  (global-evil-matchit-mode 1))

(provide 'jpdl/evil)
;;; evil.el ends here
