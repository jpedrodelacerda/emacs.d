;;; system.el --- Summary
;;; Commentary:

;;; Code:

(use-package centaur-tabs
  :demand
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  (helpful-mode . centaur-tabs-local-mode)
  :config
  (centaur-tabs-mode +1)
  (setq centaur-tabs-set-bar 'under)
  (setq x-underline-at-descent-line t)
  (centaur-tabs-headline-match)
  (setq centaur-tabs-style "wave"
        centaur-tabs-set-modified-marker t
        centaur-tabs-modified-marker " ● "
        centaur-tabs-cycle-scope 'tabs
        centaur-tabs-height 30
        centaur-tabs-set-icons t
        ;; centaur-tabs-show-navigation-buttons t
        centaur-tabs-close-button "  ")
  (centaur-tabs-group-by-projectile-project)
  (setq centaur-tabs-cycle-scope 'tabs)
  (defun centaur-tabs-buffer-groups ()
    "`centaur-tabs-buffer-groups' control buffers' group rules.

    Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
    All buffer name start with * will group to \"Emacs\".
    Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list
	(cond
	((or (string-equal "*" (substring (buffer-name) 0 1))
	     (memq major-mode '(magit-process-mode
				            magit-status-mode
				            magit-diff-mode
				            magit-log-mode
				            magit-file-mode
				            magit-blob-mode
				            magit-blame-mode
				            )))
	 "Emacs")
	((derived-mode-p 'prog-mode)
	 "Editing")
	((derived-mode-p 'dired-mode)
	 "Dired")
	((memq major-mode '(helpful-mode
			            help-mode))
	 "Help")
	(((memq list) major-mode '(org-mode
			                   org-agenda-clockreport-mode
			                   org-src-mode
			                   org-agenda-mode
			                   org-beamer-mode
			                   org-indent-mode
			                   org-bullets-mode
			                   org-cdlatex-mode
			                   org-agenda-log-mode
			                   diary-mode))
	 "OrgMode")
	(t
	 (centaur-tabs-get-group-name (current-buffer))))))
  :bind
  ;; ("<C-S-tab>" . centaur-tabs-backward)
  ("C-<iso-lefttab>" . centaur-tabs-backward)
  ("C-<tab>" . centaur-tabs-forward)
  ("C-w" . kill-buffer)
  ("C-c C-<left>" . centaur-tabs-move-current-tab-to-left)
  ("C-c C-<right>" . centaur-tabs-move-current-tab-to-right)
  ("C-c t s" . centaur-tabs-counsel-switch-group)
  ("C-c t p" . centaur-tabs-group-by-projectile-project)
  ("C-c t g" . centaur-tabs-group-buffer-groups)
  (:map evil-normal-state-map
	  ("g t" . centaur-tabs-forward)
	  ("g T" . centaur-tabs-backward)))

(provide 'jpdl/tabs)
;;; tabs.el ends here
