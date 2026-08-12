;;; evil.el --- Summary  -*- lexical-binding: t; -*-

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
  :hook ((after-init . (lambda () (jpdl/line-number-relative)))
         (evil-insert-state-entry . (lambda () (jpdl/line-number-absolute)))
         (evil-insert-state-exit . (lambda () (jpdl/line-number-relative))))
  :general
  (:keymaps 'global-map
            "C-s" 'evil-write
            "C--" 'evil-jump-backward
            "C-=" 'evil-jump-forward
            "M-2" 'evil-jump-items
            [remap evil-quit] 'delete-window)
  (:keymaps 'org-mode-map
            [remap evil-find-file-at-point] 'org-open-at-point
            )
  (jpdl/spc-leader
    "[" 'evil-jump-backward
    "," 'evil-jump-backward
    "]" 'evil-jump-forward
    "/" 'evil-jump-forward
    "x s" 'evil-write
    "Z Q" 'evil-delete-buffer
    "z q" 'delete-window
    "Z Z" 'jpdl/save-and-kill-buffer
    "z z" 'jpdl/save-and-kill-buffer)
  :config
  (evil-mode 1)
  (setq evil-emacs-state-mode nil)
  ;; Disable abbrev expansion when hit escape
  (general-def :states '(normal motion insert) "M-." 'nil)

  (defun jpdl/save-and-delete-window ()
    "Save buffer contents and quit window."
    (interactive)
    (save-buffer)
    (set (make-local-variable 'kill-buffer-query-functions) nil)
    (kill-buffer (current-buffer)))
  (defun jpdl/save-and-kill-buffer ()
    "Save buffer contents and kill buffer."
    (interactive)
    (save-buffer)
    (set (make-local-variable 'kill-buffer-query-functions) nil)
    (kill-buffer (current-buffer)))

  (defun jpdl/kill-buffer ()
    "Save buffer contents and kill buffer."
    (interactive)
    (set (make-local-variable 'kill-buffer-query-functions) nil)
    (kill-buffer (current-buffer)))

  (evil-ex-define-cmd "q" 'delete-window)
  (evil-ex-define-cmd "wq" 'jpdl/save-and-delete-window)
  (evil-ex-define-cmd "Q" 'evil-delete-buffer)
  (evil-ex-define-cmd "k" 'evil-delete-buffer)
  (evil-ex-define-cmd "wk" 'jpdl/save-and-kill-buffer)
  (evil-ex-define-cmd "wQ" 'jpdl/save-and-kill-buffer)
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
  :after (evil)
  :config
  (setq forge-add-default-bindings nil)
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
