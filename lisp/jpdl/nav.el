;;; nav,el --- Summary

;;; Commentary:

;;; Code:

(require 'jpdl/utils)

(use-package windmove
  :bind (("M-<up>"    . windmove-up   )
  		 ("M-<down>"  . windmove-down )
  		 ("M-<right>" . windmove-right)
  		 ("M-<left>"  . windmove-left )
  		 ("C-M-r"     . split-window-horizontally-and-switch)
  		 ("C-M-d"     . split-window-vertically-and-switch)
         ))

(defun split-window-below-and-switch ()
  "Split the window horizontally, then switch to the new pane."
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun split-window-right-and-switch ()
  "Split the window vertically, then switch to the new pane."
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(global-set-key (kbd "C-x 2") 'split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'split-window-right-and-switch)

(global-set-key (kbd "C-k") 'kill-buffer-and-window)

(provide 'jpdl/nav)
;;; nav.el ends here
