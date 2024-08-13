;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PERFORMANCE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Increase garbage collection threshold for lsp-mode
(setq gc-cons-threshold 100000000)

;; Increase data Emacs reads from the process
(setq read-process-output-max (* 1024 1024)) ;; 1mb
