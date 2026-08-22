;;; read.el -- Summary:  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(use-package pdf-tools
  :straight t
  :init
  (evil-set-initial-state 'pdf-view-mode 'normal)
  (pdf-tools-install)
  ;; :hook
  ;; (pdf-view-mode . (lambda () (display-line-numbers-mode -1)))
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :general
  (:keymaps '(pdf-view-mode-map)
            :states '(normal)
            "] ]" 'pdf-view-next-page
            "[ [" 'pdf-view-previous-page
            "j" 'pdf-view-scroll-up-or-next-page
            "k" 'pdf-view-scroll-down-or-previous-page
            "=" 'pdf-view-enlarge
            "-" 'pdf-view-shrink))

(use-package olivetti
  :straight t
  ;; :hook (nov-mode . olivetti-mode)
  :config
  (setq-local olivetti-body-width 85))

(use-package nov
  :straight t
  :mode ("\\.epub\\'" . jpdl/setup-novel)
  :config
  (defun jpdl/setup-novel ()
    "Configure nov.el mode"
    (interactive)
    (setq-local line-spacing 0.3)
    (visual-line-mode 1)
    (nov-mode)
    (olivetti-mode)))

(use-package calibredb
  :straight t
  :general
  (jpdl/spc-leader
    "c <return>" 'calibredb)
  (:keymaps '(calibredb-search-mode-map)
            :states '(normal insert visual emacs)
            "<return>" 'calibredb-find-file
            "q" 'calibredb-search-quit
            "?" 'calibredb-dispatch
            "a" 'calibredb-add
            "A" 'calibredb-add-dir
            "c" 'calibredb-clone
            "." 'calibredb-open-dired
            "J" 'evil-scroll-page-down
            "K" 'evil-scroll-page-up
            "C-j" 'calibredb-show-next-entry
            "C-k" 'calibredb-show-previous-entry
            "l" 'calibredb-library-list
            "n" 'calibredb-library-next
            "p" 'calibredb-library-previous
            "s" 'calibredb-set-metadata-dispatch
            "S" 'calibredb-switch-library
            "o" 'calibredb-find-file
            "O" 'calibredb-find-file-other-frame
            "v" 'calibredb-view
            "V" 'calibredb-open-file-with-default-tool
            "." 'calibredb-open-dired
            "b" 'calibredb-catalog-bib-dispatch
            "e" 'calibredb-export-dispatch
            "r" 'calibredb-search-refresh-and-clear-filter
            "R" 'calibredb-search-refresh-or-resume
            "q" 'calibredb-search-quit
            "m" 'calibredb-mark-and-forward
            "f" 'calibredb-toggle-favorite-at-point
            "x" 'calibredb-toggle-archive-at-point
            "h" 'calibredb-toggle-highlight-at-point
            "u" 'calibredb-unmark-and-forward
            "i" 'calibredb-edit-annotation
            "<tab>" 'calibredb-toggle-view-at-point
            "M-n" 'calibredb-show-next-entry
            "M-p" 'calibredb-show-previous-entry)
  :config
  (setq calibredb-root-dir "~/alexandria"
        calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir)
        calibredb-library-alist `((,calibredb-root-dir (name . "alexandria")))))

(provide 'jpdl/read)
;;; read.el ends here
