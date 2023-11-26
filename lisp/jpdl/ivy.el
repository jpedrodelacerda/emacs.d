;;; ivy.el --- Summary
;;; Commentary:

;;; Code:
(use-package ivy
  :config
  (setq ivy-mode t)
  (setq ivy-count-format "(%d/%d) ") ; display (current/total) instead of just total
  (setq ivy-format-function 'ivy-format-function-line) ; highlight the entire line
  (setq ivy-use-selectable-prompt t))


(use-package ivy-posframe
  :after (ivy ivy-rich)
  :diminish
  :config
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center))
  ;; ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center))
  ;;       ivy-posframe-height-alist '((t . 20)))
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
  (setq ivy-posframe-height 20)
  (setq ivy-posframe-width nil)
  (ivy-posframe-mode +1))

(use-package ivy-hydra
  :after (ivy))

(use-package ivy-rich
  :after (ivy counsel)
  :preface
  (defun ivy-rich-switch-buffer-icon (candidate)
    (with-current-buffer
        (get-buffer candidate)
      (all-the-icons-icon-for-mode major-mode)))

  :config
  (setq ivy-height 10)
  (setq ivy-use-virtual-buffers t)
  (ivy-rich-mode +1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  ;; :init
  (setq ivy-rich-display-transformers-list
        '(ivy-switch-buffer
          (:columns
           ((ivy-rich-switch-buffer-icon (:width 1))
            (ivy-switch-buffer-transformer (:width 30))
            (ivy-rich-switch-buffer-size (:width 7))
            (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
            (ivy-rich-switch-buffer-project (:width 15 :face success))
            (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
           :predicate
           (lambda (cand) (get-buffer cand)))

          counsel-find-file
          (:columns
           ((ivy-read-file-transformer)
            (ivy-rich-counsel-find-file-truename (:face font-lock-doc-face))))

          counsel-M-x
          (:columns
           ((counsel-M-x-transformer (:width 40))
            (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))

          counsel-describe-function
          (:columns
           ((counsel-describe-function-transformer (:width 40))
            (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))

          counsel-describe-variable
          (:columns
           ((counsel-describe-variable-transformer (:width 40))
            (ivy-rich-counsel-variable-docstring (:face font-lock-doc-face))))

          counsel-recentf
          (:columns
           ((ivy-rich-candidate (:width 0.8))
            (ivy-rich-file-last-modified-time (:face font-lock-comment-face))))

          package-install
          (:columns
           ((ivy-rich-candidate (:width 30))
            (ivy-rich-package-version (:width 16 :face font-lock-comment-face))
            (ivy-rich-package-archive-summary (:width 7 :face font-lock-builtin-face))
            (ivy-rich-package-install-summary (:face font-lock-doc-face))))))
  ;; (setq ivy-rich-display-transformers-list ; max column width sum = (ivy-poframe-width - 1)
  ;;       '(ivy-switch-buffer
  ;;         (:columns
  ;;          ((ivy-rich-switch-buffer-icon (:width 2))
  ;;           (ivy-rich-candidate (:width 35))
  ;;           (ivy-rich-switch-buffer-project (:width 15 :face success))
  ;;           (ivy-rich-switch-buffer-major-mode (:width 13 :face warning)))
  ;;          :predicate
  ;;          #'(lambda (cand) (get-buffer cand)))
  ;;         counsel-M-x
  ;;         (:columns
  ;;          ((counsel-M-x-transformer (:width 35))
  ;;           (ivy-rich-counsel-function-docstring (:width 34 :face font-lock-doc-face))))
  ;;         counsel-describe-function
  ;;         (:columns
  ;;          ((counsel-describe-function-transformer (:width 35))
  ;;           (ivy-rich-counsel-function-docstring (:width 34 :face font-lock-doc-face))))
  ;;         counsel-describe-variable
  ;;         (:columns
  ;;          ((counsel-describe-variable-transformer (:width 35))
  ;;           (ivy-rich-counsel-variable-docstring (:width 34 :face font-lock-doc-face))))
  ;;         package-install
  ;;         (:columns
  ;;          ((ivy-rich-candidate (:width 25))
  ;;           (ivy-rich-package-version (:width 12 :face font-lock-comment-face))
  ;;           (ivy-rich-package-archive-summary (:width 7 :face font-lock-builtin-face))
  ;;           (ivy-rich-package-install-summary (:width 23 :face font-lock-doc-face))))))
  )

(use-package all-the-icons-ivy-rich
  :after (all-the-icons ivy ivy-rich)
  :init (all-the-icons-ivy-rich-mode 1)
  :config
  (setq all-the-icons-ivy-rich-icon t)
  (setq all-the-icons-ivy-rich-color-icon t))

(provide 'jpdl/ivy)
;;; ivy.el ends here
