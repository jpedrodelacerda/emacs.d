;;; corfu.el --- Summary:

;;; Commentary:
;; Corfu for completion and orderless for fuzzing

;;; Code:

(use-package corfu
  :straight t
  :hook
  (lsp-completion-mode . jpdl/lsp-mode-setup-completion)
  (minibuffer-setup . corfu-enable-always-in-minibuffer)
  (corfu--done . corfu-popupinfo-hide)
  :general
  ("C-`" 'completion-at-point)
  (:keymaps 'corfu-map
            "DEL" 'corfu-quit
            "<backspace>" 'corfu-quit
            "C-y" 'cofru-insert
            "C-n" 'corfu-next
            "<tab>" 'corfu-next
            "C-p" 'corfu-previous
            "<backtab>" 'corfu-previous
            "M-d" 'corfu-popupinfo-toggle
            "M-n" 'corfu-popupinfo-scroll-down
            "M-n" 'corfu-popupinfo-scroll-up
            "M-l" 'corfu-show-location)
  :custom
  (tab-always-indent 'complete)
  (completion-cycle-threshold nil)
  (corfu-separator ?\s)
  (corfu-quit-no-match 'separator)
  (corfu-preview-current 'insert)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.25)
  (corfu-min-width 80)
  (corfu-max-width corfu-min-width)
  (corfu-count 14)
  (corfu-cycle t)
  (lsp-completion-provider :none)
  :init
  (global-corfu-mode)
  :config
  (defun corfu-enable-always-in-minibuffer ()
    "Enable Corfu in the minibuffer if Vertico/Mct are not active."
    (unless (or (bound-and-true-p mct--active) ; Useful if I ever use MCT
                (bound-and-true-p vertico--input))
      (setq-local corfu-auto nil)       ; Ensure auto completion is disabled
      (corfu-mode 1)))
  :init
  (defun jpdl/orderless-dispatch-flex-first (_pattern index _total)
    (and (eq index 0) 'orderless-flex))

  (defun jpdl/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless))
    ;; Optionally configure the first word as flex filtered.
    (add-hook 'orderless-style-dispatchers #'jpdl/orderless-dispatch-flex-first nil 'local)
    ;; Optionally configure the cape-capf-buster.
    (setq-local completion-at-point-functions (list (cape-capf-buster #'lsp-completion-at-point)))))

(use-package cape
  :straight t
  :general
  (:prefix "M-k" :keymaps 'global-map :states '(normal insert visual)
           "p" 'completion-at-point
           "t" 'complete-tag
           "d" 'cape-dabbrev
           "f" 'cape-file
           "k" 'cape-keyword
           "s" 'cape-symbol
           "a" 'cape-abbrev
           "i" 'cape-ispell
           "l" 'cape-line
           "w" 'cape-dict
           "\\" 'cape-tex
           "_" 'cape-tex
           "^" 'cape-tex
           "&" 'cape-sgml
           "r" 'cape-rfc1345))


(use-package kind-icon
  :straight t
  :after corfu
  :hook
  (darkman-toggle . kind-icon-reset-cache)
  :custom
  (kind-icon-use-icons t)
  (kind-icon-default-face 'corfu-default)
  (kind-icon-blend-background nil)
  (kind-icon-blend-frac 0.08)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(provide 'jpdl/corfu)
;;; corfu.el ends here
