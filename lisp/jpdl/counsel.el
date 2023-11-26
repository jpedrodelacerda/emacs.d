;;; counsel.el --- Summary
;;; Commentary:

;;; Code:
(use-package counsel
  :init
  (setq counsel-mode t)
  :bind (("M-x" . counsel-M-x)
         ("C-x C-v" . counsel-find-file)
         ("C-x C-b" . counsel-buffer-or-recentf)
         (:map evil-normal-state-map
               ("SPC s v" . counsel-find-file)))
  :chords (:map evil-normal-state-map
                ("SPCsv" . counsel-find-files)))

(use-package smex
  :after counsel)

(provide 'jpdl/counsel)
;;; counsel.el ends here
