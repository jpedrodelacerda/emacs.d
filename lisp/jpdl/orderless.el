;;; orderless.el --- Summary
;;; Commentary:

;;; Code:

(use-package orderless
  :straight t
  :general
  (:keymaps 'minibuffer-local-completion-map
            "C-l" 'jpdl/match-components-literally
            "C-f" 'jpdl/match-components-flex)
  :config
  (defun jpdl/match-components-literally ()
    "Components match literally for the rest of the session."
    (interactive)
    (setq-local orderless-matching-styles '(orderless-literal)
                orderless-style-dispatchers nil))
  (defun jpdl/match-components-flex ()
    "Components match flex for the rest of the session."
    (interactive)
    (setq-local orderless-matching-styles '(orderless-flex)
                orderless-style-dispatchers nil))
  (setq completion-styles '(orderless basic)
        orderless-matching-styles '(orderless-literal orderless-prefixes orderless-regexp orderless-flex)
        ;; orderless-matching-styles '(orderless-literal orderless-prefixes orderless-initialism orderless-regexp orderless-flex)
        completion-category-defaults nil
        completion-category-overrides '((file  (styles . (basic partial-completion))))))

(provide 'jpdl/orderless)
;;; orderless.el ends here
