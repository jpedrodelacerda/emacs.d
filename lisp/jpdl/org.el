;;; org.el --- Summary  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package org
  :defer
  :straight (:type built-in)
  ;; :straight `(org
  ;;             :fork (:host nil
  ;;                          :repo "https://git.tecosaur.net/tec/org-mode.git"
  ;;                          :branch "dev"
  ;;                          :remote "tecosaur")
  ;;             :files (:defaults "etc")
  ;;             :build t
  ;;             :pre-build
  ;;             (with-temp-file "org-version.el"
  ;;               (require 'lisp-mnt)
  ;;               (let ((version
  ;;                      (with-temp-buffer
  ;;                        (insert-file-contents "lisp/org.el")
  ;;                        (lm-header "version")))
  ;;                     (git-version
  ;;                      (string-trim
  ;;                       (with-temp-buffer
  ;;                         (call-process "git" nil t nil "rev-parse" "--short" "HEAD")
  ;;                         (buffer-string)))))
  ;;                 (insert
  ;;                  (format "(defun org-release () \"The release version of Org.\" %S)\n" version)
  ;;                  (format "(defun org-git-version () \"The truncate git commit hash of Org mode.\" %S)\n" git-version)
  ;;                  "(provide 'org-version)\n"))))
  ;; :straight (:type built-in)
  :hook
  (org-shiftup-final . windmove-up)
  (org-shiftleft-final . windmove-left)
  (org-shiftdown-final . windmove-down)
  (org-shiftright-final . windmove-right)
  (org-mode . jpdl/setup-electric-pair-org-mode)
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
    "g f" 'org-open-at-point
    "c c" 'org-ctrl-c-ctrl-c
    "c e" 'org-edit-special
    "c p" 'org-babel-previous-src-block
    "c k" 'org-babel-previous-src-block
    "c n" 'org-babel-next-src-block
    "c j" 'org-babel-next-src-block
    "o i" 'org-toggle-inline-images
    "o p" 'org-toggle-pretty-entities
    "o l" 'org-latex-preview)
  (jpdl/spc-leader :keymaps 'org-src-mode-map
    "c c" 'org-edit-src-quit
    "c k" 'org-edit-src-abort)
  :config
  (setq org-directory (file-truename (concat (getenv "HOME") "/org"))
        org-ellipsis " ..."
        org-src-tab-acts-natively t
        org-id-track-globally t
        org-support-shift-select 'always
        org-export-with-sub-superscripts nil
        org-confirm-babel-evaluate nil
        org-src-preserve-indentation t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-pretty-entities nil
        org-pretty-entities-include-sub-superscripts t
        org-use-sub-superscripts "{}"
        org-export-with-sub-superscripts "{}")
  (unless (file-exists-p org-directory)
    make-directory org-directory)
  (setq org-default-notes-file (concat org-directory "/refile.org"))
  (defun jpdl/setup-electric-pair-org-mode ()
    "Configure `electric-pair' for `org-mode'. Mainly to ignore `<' for snippets"
    (interactive)
    (setq-local electric-pair-inhibit-predicate
                `(lambda (c)
                   (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))

;; (use-package org-latex-preview
;;   :straight (:type built-in)
;;   ;; Turn on `org-latex-preview-mode', it's built into Org and much faster/more
;;   ;; featured than org-fragtog. (Remember to turn off/uninstall org-fragtog.)
;;   ;; (add-hook 'org-mode-hook 'org-latex-preview-mode)
;;   :hook (org-mode . org-latex-preview-mode)
;;   :config
;;   ;; Increase preview width
;;   (plist-put org-latex-preview-appearance-options
;;              :page-width 0.8)

;;   ;; ;; Use dvisvgm to generate previews
;;   ;; ;; You don't need this, it's the default:
;;   (setq org-latex-preview-process-default 'dvisvgm)


;;   ;; ;; Block C-n, C-p etc from opening up previews when using `org-latex-preview-mode'
;;   ;; (setq org-latex-preview-mode-ignored-commands
;;   ;;       '(next-line previous-line mwheel-scroll
;;   ;;         scroll-up-command scroll-down-command))

;;   ;; ;; Enable consistent equation numbering
;;   ;; (setq org-latex-preview-numbered t)

;;   ;; Bonus: Turn on live previews.  This shows you a live preview of a LaTeX
;;   ;; fragment and updates the preview in real-time as you edit it.
;;   ;; To preview only environments, set it to '(block edit-special) instead
;;   (setq org-latex-preview-mode-display-live t)

;;   ;; More immediate live-previews -- the default delay is 1 second
;;   (setq org-latex-preview-mode-update-delay 0.25))



(use-package autoinsert
  :straight (:type built-in)
  :general
  (jpdl/spc-leader
    "a i" 'auto-insert)
  :config
  (define-auto-insert 'org-mode
    '(nil
      "#+OPTIONS: ^:{}")))

(use-package ob-async
  :straight t
  :after org)
;; (use-package ob-shell
;;   :straight nil)

;; (use-package inheritenv
;;   :straight t
;;   :config
;;   (advice-add 'org-babel-execute-src-block :around #'inheritenv-apply))

;; Prettify UI
(use-package org-modern
  :straight t
  :after (org org-agenda)
  :hook (after-init . global-org-modern-mode)
  :config
  (setq org-modern-todo t
        org-modern-hide-stars nil
        org-modern-horizontal-rule t
        org-modern-star 'replace
        org-modern-keyword "‣ "
        ;; org-modern-block-fringe 0
        org-modern-table nil))
;; :hook ((org-mode . org-modern-mode)
;;        (org-agenda-finalize . org-modern-agenda))
;; (org-modern-mode . (lambda ()
;;                      "Adapt `org-modern-mode'."
;;                      ;; Disable Prettify Symbols mode
;;                      (setq prettify-symbols-alist nil)
;;                      (prettify-symbols-mode -1)))))

;; (use-package org-superstar
;;   :straight t
;;   :after (org)
;;   :hook (org-mode . org-superstar-mode))

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
     "n <return>" 'org-roam-node-insert-immediate
     "n p" 'org-roam-preview-visit
     "n t" 'org-roam-tag-add
     "n T" 'org-roam-tag-remove
     "n a" 'org-roam-alias-add
     "n A" 'org-roam-alias-remove))
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

(use-package citar
  :straight t
  :custom
  (citar-bibliography '("~/org/research/references.bib"))
  :hook
  (LaTeX-mode . citar-capf-setup)
  (org-mode . citar-capf-setup))

(use-package citar-org-roam
  :straight t
  :after (citar org-roam)
  :config (citar-org-roam-mode))

(use-package org-ref
  :straight t)

(use-package org-roam-bibtex
  :after org-roam
  :config
  (require 'org-ref))

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
  (setq org-agenda-files (list
                          (file-truename org-directory)
                          (file-truename (concat org-directory "/agenda"))
                          (file-truename (concat org-directory "/roam"))))
  ;; (setq org-agenda-files (list (file-truename (concat org-directory "/agenda"))))
  (setq org-agenda-prefix-format
        '((agenda . " %i %-12:c%?-12t% s")
          (timeline . "  % s")
          (todo . " %i %-12:c")
          (tags . " %i %-12:c")
          (search . " %i %-12:c")))
  (setq org-refile-targets '((org-agenda-files :maxlevel . 2)))
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


(use-package pdf-tools
  :straight t)

(use-package org-noter
  :init
  (setq org-noter-default-notes-file-names '("booknotes.org" "notes.org")
	    org-noter-notes-search-path '("~/org/booknotes")
	    org-noter-default-heading-title  "page $p$"
	    org-noter-auto-save-last-location t
        org-noter-always-create-frame nil
	    org-noter-insert-selected-text-inside-note t
        org-noter-kill-frame-at-session-end t)
  :general
  (:keymaps '(org-noter-doc-mode-map)
            :states '(motion)
            "q" 'org-noter-kill-session)
  (jpdl/spc-leader
    :keymaps '(pdf-view-mode-map nov-mode-map)
    "o n" 'org-noter)
  (jpdl/spc-leader
    :keymaps '(org-noter-doc-mode-map)
    "o p" 'org-noter-insert-precise-note
    "o i" 'org-noter-insert-note
    "o I" 'org-noter-insert-note-no-questions
    "o s" 'org-noter-sync-current-note
    "o S" 'org-noter-sync-current-page-or-chapter)
  (jpdl/spc-leader
    :keymaps '(org-noter-doc-mode-map)
    "q" 'org-noter-kill-session)
  (:keymaps '(pdf-view-mode-map nov-mode-)
            :states '(normal)
            "o n" 'org-noter)
  (:keymaps '(org-noter-doc-mode-map)
            :states '(normal)
            "o p" 'org-noter-insert-precise-note
            "o i" 'org-noter-insert-note
            "o I" 'org-noter-insert-note-no-questions
            "o s" 'org-noter-sync-current-note
            "o S" 'org-noter-sync-current-page-or-chapter
            "q" 'org-noter-kill-session)
  :config
  (org-noter-enable-org-roam-integration))

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
