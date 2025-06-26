;;; pairs.el --- Summary:  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package electric-pair
  :straight (:type built-in)
  :no-require
  :hook (after-init . electric-pair-mode))

(use-package puni
  :straight t
  :general
  (:keymaps 'puni-mode-map
            "C-k" 'nil
            "C-S-k" 'nil
            "C-d" 'nil
            "<delete>" 'nil
            "M-d" 'nil
            "M-<delete>" 'nil
            "C-j d" 'puni-squeeze
            "C-j r" 'puni-raise
            "C-j c" 'puni-convolute
            "C-j s f" 'puni-slurp-forward
            "C-j s b" 'puni-slurp-backward
            "C-j b f" 'puni-slurp-forward
            "C-j b b" 'puni-slurp-backward)
  (jpdl/spc-leader :keymaps 'puni-mode-map
    "j r" 'puni-squeeze
    "j r" 'puni-raise
    "j c" 'puni-convolute
    "j s f" 'puni-slurp-forward
    "j s b" 'puni-slurp-backward
    "j b f" 'puni-slurp-forward
    "j b b" 'puni-slurp-backward)
  (:states 'visual
           "<backspace>" 'puni-backward-delete-char)
  :config
  (puni-global-mode))


(provide 'jpdl/pairs)
;;; pairs.el ends here
