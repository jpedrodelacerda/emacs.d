;;; org.el --- Summary

;;; Commentary:

;;; Code:
(use-package org
  :straight (:type built-in)
  :hook
  (org-shiftup-final . windmove-up)
  (org-shiftleft-final . windmove-left)
  (org-shiftdown-final . windmove-down)
  (org-shiftright-final . windmove-right)
  :config
  (setq org-directory (concat (getenv "HOME") "/org")
        org-ellipsis " ..."
        org-src-tab-acts-natively t
        org-support-shift-select 'always
        org-export-with-sub-superscripts nil))

(use-package org-fragtog
  :straight t
  :after (org)
  :diminish
  :hook (org-mode . org-fragtog-mode))


;; Prettify UI
(use-package org-modern
  :straight t
  :after (org)
  :hook ((org-mode . org-modern-mode)
         (org-agenda-finalize . org-modern-agenda)
         (org-modern-mode . (lambda ()
                              "Adapt `org-modern-mode'."
                              ;; Disable Prettify Symbols mode
                              (setq prettify-symbols-alist nil)
                              (prettify-symbols-mode -1)))))

(use-package org-bullets
  :straight t
  :after (org)
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ox-reveal
  :straight t
  :after (org)
  :pin melpa)

(use-package ob-mermaid
  :straight t
  :after (org)
  :after (mermaid-mode))


(use-package org-rich-yank
  :straight t
  :after (org)
  :general (:keymaps 'org-mode-map
                     "C-M-y" . org-rich-yank))

(use-package toc-org
  :straight t
  :after (org)
  :hook (org-mode . toc-org-mode))

(use-package org-roam
  :straight t
  :diminish
  :after (org)
  :general
  ("C-c n l" 'org-roam-buffer-toggle
   "C-c n i" 'jpdl/org-roam-node-insert
   "C-c n I" 'org-roam-node-insert-immediate
   "C-c n <return>" 'org-roam-node-insert-immediate
   "C-c n f" 'jpdl/org-roam-node-find
   "C-c n p" 'org-roam-preview-visit
   "C-c n t" 'org-roam-tag-add
   (jpdl/spc-leader
     "n f" 'jpdl/org-roam-node-find
     "n l" 'org-roam-buffer-toggle
     "n i" 'jpdl/org-roam-node-insert
     "n I" 'org-roam-node-insert-immediate
     "n <return>" 'org-roam-insert-immediate
     "n p" 'org-roam-preview-visit
     "n t" 'org-roam-tag-add))
  :config
  (defun jpdl/org-roam-node-find ()
    (interactive)
    (unwind-protect
        ;; unwind-protect is required to turn off ivy
        ;; even when you cancel without choosing a node
        (progn
          (ivy-mode +1)
          (org-roam-node-find))
      (ivy-mode -1)))
  (defun jpdl/org-roam-node-insert (arg &rest args)
    (interactive)
    (unwind-protect
        ;; unwind-protect is required to turn off ivy
        ;; even when you cancel without choosing a node
        (progn
          (ivy-mode +1)
          (org-roam-node-insert args))
      (ivy-mode -1)))
  (defun org-roam-node-insert-immediate (arg &rest args)
    (interactive "P")
    (let ((args (cons arg args))
          (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                    '(:immediate-finish t)))))
      (apply #'jpdl/org-roam-node-insert args)))
  (setq org-roam-directory (concat org-directory "/roam"))
  (setq find-file-visit-truename t)
  (setq org-roam-node-display-template (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (setq org-roam-dailies-directory (concat org-directory "/daily"))
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))))
  (setq org-roam-completion-everywhere t)
  (org-roam-setup)
  (org-roam-db-autosync-mode))

;; (use-package deft
;;   :straight t
;;   :after (org-roam)
;;   :general
;;   ("C-c n d" 'deft)
;;   (jpdl/spc-leader
;;     "n d" 'deft)
;;   :config
;;   (setq deft-directory org-roam-directory
;;         deft-extensions '("md" "org")))

(use-package org-roam-ui
  :straight t
  :after (org-roam)
  :general
  ("C-c n u" 'org-roam-ui-mode)
  (jpdl/spc-leader
    "n u" 'org-roam-ui-mode
    "n o" 'org-roam-ui-open)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil))

(use-package org-timeline
  :hook (org-agenda-finalize . org-timeline-insert-timeline))

;; Pomodoro
(use-package org-pomodoro
  :straight t
  :after (org)
  :custom-face
  (org-pomodoro-mode-line ((t (:inherit warning))))
  (org-pomodoro-mode-line-overtime ((t (:inherit error))))
  (org-pomodoro-mode-line-break ((t (:inherit success))))
  :general
  (:keymaps 'org-mode-map
            "C-c C-x m" 'org-pomodoro
            "K" 'org-pomodoro))

(use-package org-agenda
  :straight (:type built-in)
  :after org
  :general
  (jpdl/spc-leader
    "a c" 'org-capture
    "a a" 'org-agenda
    "a l" 'org-agenda-list)
  :init
  (setq org-agenda-files (list (concat org-directory "/agenda")))
  :config
  (setq
   ;; Edit settings
   org-auto-align-tags nil
   org-tags-column 0
   org-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t

   ;; Org styling, hide markup etc.
   org-hide-emphasis-markers t
   org-pretty-entities t

   ;; Agenda styling
   org-agenda-tags-column 0
   org-agenda-block-separator ?─
   org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "◀── now ─────────────────────────────────────────────────"))


(provide 'jpdl/org)
;;; org.el ends here
