;;; babel.el --- summary -*- lexical-binding: t -*-
;;; Commentary:

;; commentary

;;; Code:

(use-package mermaid-ts-mode
  :straight t)

(use-package ob-mermaid
  :straight t
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   (append org-babel-load-languages
           '((mermaid . t)))))

(use-package d2-mode
  :straight t
  :mode "\\.d2\\'"
  :custom
  (d2-flags '("-s" "-t" "6"))
  :config
  (add-to-list 'org-src-lang-modes '("d2" . d2))
  (org-babel-do-load-languages
   'org-babel-load-languages
   (append org-babel-load-languages
           '((d2 . t)))))

;; (use-package ob-d2
;;   :straight t
;;   :after org
;;   :config
;;   (add-to-list 'org-src-lang-modes '("d2" . d2))
;;   (org-babel-do-load-languages
;;    'org-babel-load-languages
;;    (append org-babel-load-languages
;;            '((d2 . t)))))

(provide 'jpdl/babel)

;;; babel.el ends here
