;;; projectile.el --- Summary

;;; Commentary:

;;; Code:

;; Handle projects
(use-package projectile
  :config
  (projectile-mode 1)
  (setq projectile-project-search-path '("~/"))
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
  :bind (("C-x C-d" . projectile-find-file-in-known-projects)
         (:map evil-normal-state-map
               (("SPC s d" . projectile-find-file-in-known-projects))))
  :chords (:map evil-normal-state-map
               (("SPCsd" . projectile-find-file-in-known-projects))))

(use-package counsel-projectile
  :after (counsel)
  :bind (("C-x C-f" . counsel-projectile-find-file)
         ("C-x C-p" . counsel-projectile-switch-project)
         ("C-x C-r" . counsel-projectile-rg)
         (:map evil-normal-state-map
               ("SPC r g" . counsel-projectile-rg)
               ("SPC s f" . counsel-projectile-find-file)))
  :chords (:map evil-normal-state-map
                ("SPCrg" . counsel-projectile-rg)
                ("SPCsf" . counsel-projectile-find-file)))

(provide 'jpdl/projectile)
;;; projectile.el ends here
