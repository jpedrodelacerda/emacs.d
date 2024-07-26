;;; nav,el --- Summary

;;; Commentary:

;;; Code:

(require 'jpdl/utils)

(use-package windmove
  :straight t
  :config
  (windmove-default-keybindings 'meta)
  :general
  ("C-M-r" 'split-window-horizontally-and-switch
   "C-M-d" 'split-window-vertically-and-switch))

(use-package windswap
  :straight t
  :config
  (windswap-default-keybindings 'meta 'control))

(global-set-key (kbd "M-e") 'toggle-window-split)

(use-package ace-window
  :straight t
  :general
  ("M-w" 'ace-swap-window))

(global-set-key (kbd "C-x 2") 'split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'split-window-right-and-switch)

(global-set-key (kbd "C-k") 'kill-buffer-and-window)

(provide 'jpdl/nav)
;;; nav.el ends here
