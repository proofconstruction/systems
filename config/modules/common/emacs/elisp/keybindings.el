;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; KEYBINDINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Window movement
;; (global-set-key (kbd "s-h")  'windmove-left)
;; (global-set-key (kbd "s-l") 'windmove-right)
;; (global-set-key (kbd "s-k")    'windmove-up)
;; (global-set-key (kbd "s-j")  'windmove-down)

;; I hate backgrounding emacs accidentally
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

;; Better completion
(global-set-key (kbd "M-/") 'hippie-expand)
