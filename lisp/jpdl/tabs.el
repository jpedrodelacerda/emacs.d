;;; tabs.el --- Summary
;;; Commentary:

;;; Code:

(use-package centaur-tabs
  :straight t
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  (helpful-mode . centaur-tabs-local-mode)
  :general
  ("C-<iso-lefttab>" 'centaur-tabs-backward
   "C-<tab>" 'centaur-tabs-forward
   "C-w" 'kill-buffer
   "C-c C-<left>" 'centaur-tabs-move-current-tab-to-left
   "C-c C-<right>" 'centaur-tabs-move-current-tab-to-right
   "C-c t s" 'centaur-tabs-counsel-switch-group
   "C-c t p" 'centaur-tabs-group-by-projectile-project
   "C-c t g" 'centaur-tabs-group-buffer-groups)
  (:states 'normal
           "g t" 'centaur-tabs-forward
	       "g T" 'centaur-tabs-backward)
  :config
  (defun centaur-tabs-hide-tab (x)
    "Do no to show buffer X in tabs."
    (let ((name (format "%s" x)))
      (or
       (string-prefix-p "*epc" name)
       (string-prefix-p "*helm" name)
       (string-prefix-p "*Helm" name)
       (string-prefix-p "*Compile-Log*" name)
       (string-prefix-p "*lsp" name)
       (string-prefix-p " *lsp" name)
       (string-prefix-p "*company" name)
       (string-prefix-p "*Flycheck" name)
       (string-prefix-p "*tramp" name)
       (string-prefix-p " *Mini" name)
       (string-prefix-p "*help" name)
       (string-prefix-p "*straight" name)
       (string-prefix-p " *temp" name)
       (string-prefix-p "*Minibuffer" name)
       (string-prefix-p "*Minibuf" name)
       (string-prefix-p "*Help" name)
       (string-prefix-p "*Embark" name)
       (string-prefix-p " *Embark" name)
       (string-prefix-p " *Treemacs" name)
       (string-prefix-p "*which" name)
       (string-prefix-p " *which" name)
       (string-prefix-p "*eldoc" name)
       (string-prefix-p " *eldoc" name)
       (and (string-prefix-p "magit" name)
            (not (file-name-extension name)))
       )))
  (setq centaur-tabs-set-bar 'under
        x-underline-at-descent-line t
        centaur-tabs-style "wave"
        centaur-tabs-set-modified-marker t
        centaur-tabs-modified-marker " ● "
        centaur-tabs-cycle-scope 'tabs
        centaur-tabs-height 30
        centaur-tabs-set-icons t
        centaur-tabs-close-button "  "
        centaur-tabs-cycle-scope 'tabs)
  (centaur-tabs-mode +1))


(provide 'jpdl/tabs)
;;; tabs.el ends here
