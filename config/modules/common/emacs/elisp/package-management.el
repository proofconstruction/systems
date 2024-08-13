;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Do not ensure packages---they are installed with Nix
(setq use-package-always-ensure nil)

;; (setq use-package-verbose t)
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(require 'diminish)

(require 'package)
(setq package-archives nil)
(setq package-enable-at-startup nil)
(package-initialize)

;; enable emacs-anywhere
;;(load "~/.emacs.d/emacs-anywhere.el")
