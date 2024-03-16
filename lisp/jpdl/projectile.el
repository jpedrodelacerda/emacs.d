;;; projectile.el --- Summary

;;; Commentary:

;;; Code:

;; Handle projects
(use-package projectile
  :straight t
  :config
  (projectile-mode 1)
  (setq projectile-project-search-path '("~/dotfiles" "~/dotnix" "~/projetos"))
  (projectile-discover-projects-in-search-path)
  (setq projectile-completion-system 'ivy)
  (which-key-add-key-based-replacements
    "C-c p 4" "other-window"
    "C-c p 5" "other-frame"
    "C-c p s" "search"
    "C-c p x" "execute")
  ;; Set frame title
  (setq frame-title-format '(concat ("emacs - ":eval (projectile-project-name))))
  (setq projectile-indexing-method 'alien)
  :bind-keymap ("C-c p" . projectile-command-map)
  :bind (("C-x C-v" . projectile-find-file-in-known-projects)
         ("C-x 4 C-v" . (lambda () (interactive) (other-window-prefix) (projectile-find-file-in-known-projects)))
         (:map evil-normal-state-map
               (("SPC s v" . projectile-find-file-in-known-projects)
                ("SPC 4 s v" . (lambda () (interactive) (other-window-prefix) (projectile-find-file-in-known-projects))))))
  :chords (:map evil-normal-state-map
                (("SPCsv" . projectile-find-file-in-known-projects)
                 ("SPC4sv" . (lambda () (interactive) (other-window-prefix) (projectile-find-file-in-known-projects))))))

(provide 'jpdl/projectile)
;;; projectile.el ends here
