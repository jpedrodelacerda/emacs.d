;;; corfu.el --- Summary:

;;; Commentary:
;; Corfu for completion and orderless for fuzzing

;;; Code:

(use-package corfu
  :straight t
  :hook
  ;; (lsp-completion-mode . jpdl/lsp-mode-setup-completion)
  (minibuffer-setup . corfu-enable-always-in-minibuffer)
  (corfu-mode . corfu-popupinfo-mode)
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
            "M-p" 'corfu-popupinfo-scroll-down
            "M-n" 'corfu-popupinfo-scroll-up
            "M-l" 'corfu-show-location)
  :custom
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  (completion-cycle-threshold nil)
  (corfu-separator ?\s)
  (corfu-quit-no-match t)
  (corfu-preview-current nil)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.25)
  (corfu-min-width 80)
  (corfu-max-width corfu-min-width)
  (corfu-count 14)
  (corfu-cycle t)
  :init
  (defun jpdl/orderless-dispatch-flex-first (_pattern index _total)
    (and (eq index 0) 'orderless-flex))
  (global-corfu-mode)
  :config
  (corfu-history-mode 1)
  (savehist-mode 1)
  (add-to-list 'savehist-additional-variables 'corfu-history)
  (defun corfu-enable-always-in-minibuffer ()
    "Enable Corfu in the minibuffer if Vertico/Mct are not active."
    (unless (or (bound-and-true-p mct--active) ; Useful if I ever use MCT
                (bound-and-true-p vertico--input))
      (setq-local corfu-auto nil)       ; Ensure auto completion is disabled
      (corfu-mode 1))))

(use-package cape
  :straight t
  :general
  (:prefix "M-S-k" :keymaps 'global-map :states '(normal insert visual)
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
           "r" 'cape-rfc1345)
  :config
  (defun jpdl/eglot-capf ()
    (setq-local completion-at-point-functions
                (list (cape-super-capf
                       'eglot-completion-at-point
                       :with 'yasnippet-capf))))
  :hook (eglot-managed-mode . jpdl/eglot-capf))

(use-package yasnippet-capf
  :after (cape)
    (add-to-list 'completion-at-point-functions #'yasnippet-capf))


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
