;;; debug.el --- Summary

;;; Commentary:
;; dap and dap-ui config

;;; Code:
(use-package dap-mode
  :config
  (setq dap-auto-configure-features '(sessions locals breakpoints expressions repl controls tooltip))
  (dap-ui-mode 1)
  (dap-tooltip-mode)
  (require 'dap-gdb-lldb)
  (setq dap-gdb-lldb-debug-program '("/usr/bin/lldb-vscode"))
  (dap-register-debug-template
    "Rust::LLDB Run Configuration"
    (list :type "lldb"
          :request "launch"
          :name "LLDB::Run"
	      :gdbpath "rust-lldb"
          :target nil
          :cwd nil))
  :hook (prog-mode)
  :init
  (unbind-key "M-d")
  :bind
  (:map dap-mode
        ("<f5>" . dap-debug)
        ("<f6>" . dap-hydra)
        ("<f7>" . dap-debug-restart)
        ("C-c C-c d" . dap-hydra)
        ("M-d b" . dap-breakpoint-toggle)
        ("M-d n" . dap-next)
        ("M-d h" . dap-hydra))
  :chords
  (:map dap-mode
        ("bb" . dap-breakpoint-toggle)
        ("nn" . dap-next)
        ("dh" . dap-hydra)))

(provide 'jpdl/debug)
;;; debug.el ends here
