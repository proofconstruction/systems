;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Remove UI junk
(scroll-bar-mode 0)
(tool-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(tooltip-mode -1)
(setq visible-bell t)

;; Disable startup stuff.
(setq inhibit-startup-message t
  inhibit-startup-echo-area-message (user-login-name)
  inhibit-startup-buffer-menu t
  inhibit-startup-screen t
  initial-major-mode 'fundamental-mode)

;; Nice to have
(if (string= (system-name) "carbon")
       (display-battery-mode t))
(display-time)
(setq display-time-default-load-average 'nil)
