;;; pairs.el --- Summary:

;;; Commentary:

;;; Code:

(use-package electric-pair
  :straight (:type built-in)
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
              "M-<delete>" 'nil)
  :config
  (puni-global-mode))


(provide 'jpdl/pairs)
;;; pairs.el ends here
