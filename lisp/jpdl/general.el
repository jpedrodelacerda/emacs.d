;;; general.el - Summary:
;;; Commentary:

;;; Code:

(use-package general
  :straight t
  :config
  (general-evil-setup)
  (general-create-definer jpdl/spc-leader
    :states '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (jpdl/spc-leader
    "h k" 'describe-key
    "h v" 'describe-variable
    "h m" 'describe-keymap))

(provide 'jpdl/general)
;;; general.el ends here
