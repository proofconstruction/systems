;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; THEME
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Treat all custom themes as safe.
(setq custom-safe-themes t)

;; Load the leuven light theme after init
(add-hook 'after-init-hook (lambda () (load-theme 'leuven)))
(use-package leuven-theme
  :ensure t
  :config
    (load-theme 'leuven))
