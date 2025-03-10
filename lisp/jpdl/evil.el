;;; evil.el --- Summary

;;; Commentary:

;;; Code:

(use-package evil
  :straight t
  :init
  (setq evil-want-keybinding nil
        evil-want-integration t)
  (defun jpdl/line-number-relative ()
    (setq display-line-numbers 'relative))

  (defun jpdl/line-number-absolute ()
    (setq display-line-numbers t))
  :hook ((evil-insert-state-entry . (lambda () (jpdl/line-number-absolute)))
         (evil-insert-state-exit . (lambda () (jpdl/line-number-relative))))
  :general
  (:keymaps 'global-map
            "C-s" 'evil-write
            "C--" 'evil-jump-backward
            "C-=" 'evil-jump-forward)
  (:keymaps 'org-mode-map
            [remap evil-find-file-at-point] 'org-open-at-point)
  (jpdl/spc-leader
    "[" 'evil-jump-backward
    "," 'evil-jump-backward
    "]" 'evil-jump-forward
    "/" 'evil-jump-forward
    "x s" 'evil-write)
  :config
  (evil-mode 1)
  (setq evil-emacs-state-mode nil)
  ;; Disable abbrev expansion when hit escape
  (general-def :states '(normal motion insert) "M-." 'nil)
                                        ;(general-def :states '(normal motion insert) "C-o" 'nil)
                                        ;(general-def :states '(normal insert) "C-p" 'nil)
  (setq evil-want-fine-undo t)
  (evil-set-undo-system 'undo-fu)
  (setq evil-want-abbrev-expand-on-insert-exit nil))

(defun jpdl/bad-archer ()
  (interactive)
  (message "You have ran out of arrows!"))


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
  :after (org evil)
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
