;;; calibre.el -- Summary:

;;; Commentary:

;;; Code:


(use-package calibredb
  :straight t
  :config
  (setq calibredb-root-dir "~/alexandria"
        calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir)
        calibredb-library-alist '((expand-file-name calibredb-root-dir))))

(provide 'jpdl/calibre)
;;; calibre.el ends here
