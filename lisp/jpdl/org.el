;;; org.el --- Summary

;;; Commentary:

;;; Code:
(use-package org
  :hook
  (org-shiftup-final . windmove-up)
  (org-shiftleft-final . windmove-left)
  (org-shiftdown-final . windmove-down)
  (org-shiftright-final . windmove-right)
  :config
  (setq org-ellipsis " ..."
        org-src-tab-acts-natively t
        org-support-shift-select 'always
        org-export-with-sub-superscripts nil))

(use-package org-fragtog
  :after org
  :diminish
  :hook (org-mode . org-fragtog-mode))


;; Prettify UI
(use-package org-modern
  :hook ((org-mode . org-modern-mode)
         (org-agenda-finalize . org-modern-agenda)
         (org-modern-mode . (lambda ()
                              "Adapt `org-modern-mode'."
                              ;; Disable Prettify Symbols mode
                              (setq prettify-symbols-alist nil)
                              (prettify-symbols-mode -1)))))

(use-package org-bullets
  :straight t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ox-reveal
  :straight t
  :pin melpa)

(use-package ob-mermaid
  :straight t
  :after (mermaid-mode))


(use-package org-rich-yank
  :straight t
  :general (:keymaps 'org-mode-map
                     "C-M-y" . org-rich-yank))

(use-package toc-org
  :straight t
  :hook (org-mode . toc-org-mode))

(use-package org-roam
  :straight t
  :diminish
  :after (org)
  :general
  ("C-c n l" 'org-roam-buffer-toggle
   "C-c n i" 'org-roam-node-insert
   "C-c n f" 'org-roam-node-find
   (jpdl/spc-leader
     "n f" 'org-roam-node-find
     "n l" 'org-roam-buffer-toggle
     "n i" 'org-roam-node-insert))
  :config
  (make-directory "~/org-roam")
  (setq org-roam-directory (file-truename "~/org-roam"))
  (setq find-file-visit-truename t)
  (org-roam-db-autosync-mode))

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
  (setq org-agenda-files (quote ("~/MEGAsync/agenda/pessoal.org"
                                 "~/MEGAsync/agenda/trabalho.org"
                                 "~/MEGAsync/agenda/ufrj.org"
                                 )))
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
