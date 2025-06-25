;;; org.el --- Summary  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package org
  :straight (:type built-in)
  :hook
  (org-shiftup-final . windmove-up)
  (org-shiftleft-final . windmove-left)
  (org-shiftdown-final . windmove-down)
  (org-shiftright-final . windmove-right)
  :general
  (:keymaps 'org-mode-map :states '(normal visual emacs)
            "RET" 'org-open-at-point)
  (:keymaps 'org-mode-map :states '(normal visual insert emacs)
            [remap find-file-at-point] 'org-open-at-point
            "M-n" 'org-next-visible-heading
            "M-p" 'org-previous-visible-heading
            "C-c C-t" 'org-todo)
  (:keymaps 'org-mode-map :states '(normal visual)
            "gj" 'org-next-visible-heading
            "gk" 'org-previous-visible-heading)
  (jpdl/spc-leader :keymaps 'org-mode-map
    "o t" 'org-todo
    "RET" 'org-open-at-point
    "g f" 'org-open-at-point)
  :config
  (setq org-directory (file-truename (concat (getenv "HOME") "/org"))
        org-ellipsis " ..."
        org-src-tab-acts-natively t
        org-id-track-globally t
        org-support-shift-select 'always
        org-export-with-sub-superscripts nil)
  (unless (file-exists-p org-directory)
    make-directory org-directory)
  (setq org-default-notes-file (concat org-directory "/refile.org")))

;; Prettify UI
(use-package org-modern
  :straight t
  :after (org org-agenda)
  :hook (after-init . global-org-modern-mode))
;; :hook ((org-mode . org-modern-mode)
;;        (org-agenda-finalize . org-modern-agenda))
;; (org-modern-mode . (lambda ()
;;                      "Adapt `org-modern-mode'."
;;                      ;; Disable Prettify Symbols mode
;;                      (setq prettify-symbols-alist nil)
;;                      (prettify-symbols-mode -1)))))

(use-package org-superstar
  :straight t
  :after (org)
  :hook (org-mode . org-superstar-mode))

;; (use-package ox-reveal
;;   :straight t
;;   :after (org)
;;   :pin melpa)

(use-package org-re-reveal
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
  :general
  (:keymaps 'org-mode-map
            "C-M-y" 'org-rich-yank))

(use-package toc-org
  :straight t
  :after (org)
  :hook (org-mode . toc-org-mode))

(use-package org-sidebar
  :straight t
  :custom
  (org-sidebar-tree-side 'right)
  :general
  (jpdl/spc-leader :keymaps '(org-mode-map)
    "o s" 'org-sidebar-toggle
    "o d" 'org-sidebar-tree-toggle))

(use-package org-fragtog
  :straight t
  :after (org)
  :diminish
  :hook (org-mode . org-fragtog-mode))

(use-package org-roam
  :straight t
  :diminish
  :after (org)
  :general
  ("C-c n l" 'org-roam-buffer-toggle
   "C-c n i" 'org-roam-node-insert
   "C-c n I" 'org-roam-node-insert-immediate
   "C-c n <return>" 'org-roam-node-insert-immediate
   "C-c n f" 'org-roam-node-find
   "C-c n p" 'org-roam-preview-visit
   "C-c n t" 'org-roam-tag-add
   (jpdl/spc-leader
     "n f" 'org-roam-node-find
     "n l" 'org-roam-buffer-toggle
     "n i" 'org-roam-node-insert
     "n I" 'org-roam-node-insert-immediate
     "n <return>" 'org-roam-insert-immediate
     "n p" 'org-roam-preview-visit
     "n t" 'org-roam-tag-add))
  :config
  (setq org-roam-directory (file-truename (concat org-directory "/roam")))
  (setq org-roam-db-location (file-truename (concat org-roam-directory "/org-roam.db")))
  (setq org-roam-dailies-directory (concat org-directory "/daily"))
  (setq find-file-visit-truename t)
  (defun org-roam-node-insert-immediate (arg &rest args)
    (interactive "P")
    (let ((args (cons arg args))
          (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                    '(:immediate-finish t)))))
      (apply #'org-roam-node-insert args)))
  (setq org-roam-node-display-template (concat "${title:60}" (propertize "${tags:*}" 'face 'org-tag)))
  (setq org-roam-capture-templates
        '(("d" "default" plain
           "\n%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)
          ("s" "study" plain
           "\n%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: %^{tags}")
           :unnarrowed t)
          ("c" "class" plain
           "\n* %^{Class Code} - %^{Class Name}\n- Professor:\n  %^{Professor}\n* Agenda\n\n* Notas\n\n%?* Referências\n\n"
           :if-new (file+head "%<%Y%m%d%H%M%S>-class-${slug}.org" "#+title: ${title}\n#+filetags: %^{tags}")
           :unnarrowed t)
          ("p" "project" plain
           "* Ideia\n\n%?* Objetivo\n\n* Repositório\n\n* Roadmap\n\n* Referências\n\n"
           :if-new (file+head "%<%Y%m%d%H%M%S>-project-${slug}.org" "#+title: ${title}\n#+filetags: %^{tags}:project")
           :unnarrowed t)
          ))
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))))
  (setq org-roam-completion-everywhere t)
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
  :straight t
  :after (org-agenda)
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
            "C-c C-x m" 'org-pomodoro)
  (:keymaps 'org-mode-map :states '(normal visual emacs)
            "K" 'org-pomodoro))

(use-package org-agenda
  :straight (:type built-in)
  :general
  (jpdl/spc-leader
    "a c" 'org-capture
    "a a" 'org-agenda
    "a l" 'org-agenda-list)
  :config
  (setq org-agenda-files (list (file-truename (concat org-directory "/agenda"))))
  (setq org-refile-targets '((org-agenda-files :maxlevel . 1)))
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

(use-package org-noter
  :straight t)

(use-package pdf-tools
  :straight t
  :mode ("\\.pdf\\'" . pdf-view-mode))

(use-package org-excalidraw
  ;; Excalidraw in Org.
  ;;
  ;; A typical usage goes like this. In an Org document,
  ;;
  ;;   M-x org-excalidraw-create-drawing
  ;;
  ;; To create an Excalidraw file. Edit on the Chrome progressive web
  ;; app (PWA). When done, save the .excalidraw file. Also export an
  ;; SVG file to ~/export.svg. Back in the Org document, use
  ;;
  ;;   M-x org-excalidraw-ok-copy-svg-to-cwd
  ;;
  ;; to copy the export file to the local directory and also create a
  ;; link.
  ;;
  ;; ---------
  ;;
  ;; Note that there are a couple of versions of `org-exalidraw'. The
  ;; @wdavew version is clean but @4honor version is more
  ;; customizable, in particular, two options exist for SVG export
  ;; (`kroki' and `excalidraw_export').
  ;;
  ;; In the end, SVG export has a general issue in font handling. The
  ;; only reliable solution is to embed fonts into the SVG file
  ;; itself. `excalidraw_export' does not work reliably, and `kroki'
  ;; doesn't embed fonts.
  ;;
  ;; Excalidraw now supports font-embedded SVGs by default, and the
  ;; implementation is efficient, only embedding the glyphs actually
  ;; used. The use of manual export is thus currently recommended
  ;; approach.
  ;;
  :straight (org-excalidraw :host github :repo "4honor/org-excalidraw")
  :commands (org-excalidraw-create-drawing)
  :hook (org-mode . (lambda () (require 'org-excalidraw)))
  :config
  (defun org-excalidraw-ok-copy-svg-to-cwd (exported-file new-file)
    "Copy an Excalidraw-export SVG file to the current working directory."
    (interactive
     (list (read-file-name "Exported SVG file: "
                           (expand-file-name "/tmp/") nil nil "export.svg")
           (read-string "New SVG file name: ")))
    (let ((new-file (or (and (string-suffix-p ".svg" new-file t) new-file)
                        (format "%s.svg" new-file))))
      (copy-file exported-file (expand-file-name new-file))
      (insert (format "#+name: %1$s\n[[./%1$s]]" new-file)))))

(provide 'jpdl/org)
;;; org.el ends here
