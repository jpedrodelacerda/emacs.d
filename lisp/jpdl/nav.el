;;; nav,el --- Summary

;;; Commentary:

;;; Code:

(require 'jpdl/utils)

(use-package windmove
  :config
  (windmove-default-keybindings 'meta)
  :bind
  ("C-M-r"     . split-window-horizontally-and-switch)
  ("C-M-d"     . split-window-vertically-and-switch))

(use-package windswap
  :config
  (windswap-default-keybindings 'meta 'control))

(global-set-key (kbd "M-e") 'toggle-window-split)

(use-package ace-window
  :bind
  ("M-w" . 'ace-swap-window))

(global-set-key (kbd "C-x 2") 'split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'split-window-right-and-switch)

(global-set-key (kbd "C-k") 'kill-buffer-and-window)

(provide 'jpdl/nav)
;;; nav.el ends here
