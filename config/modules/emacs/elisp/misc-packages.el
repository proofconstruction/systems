;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org-kanban)

(use-package magit)
(use-package f)

(use-package undo-tree
  ;; Enable the undo-tree mode globally
  :init
  (setq undo-tree-visualizer-relative-timestamps t
    	undo-tree-visualizer-timestamps t
	undo-tree-auto-save-history nil)
  (global-undo-tree-mode))

(use-package tramp)

(use-package mood-line
  :config
  (mood-line-mode))

(use-package direnv
  :config
  (direnv-mode)
  (setq warning-suppress-types '(direnv)))

(use-package company
  :defer t)

(use-package olivetti)

(use-package ripgrep)

(use-package which-key
  :config
  (which-key-mode))

(use-package recentf
  :config
  (recentf-mode t))

(use-package paren
  :demand t
  :custom ((show-paren-delay 0)
  	   (show-paren-mode t)))

(use-package swiper
  :demand t
  :bind ("C-s" . swiper))

(use-package ivy
  :diminish
  :custom ((ivy-wrap t)
	   (ivy-height 8)
	   (ivy-display-style 'fancy)
	   (ivy-use-virtual-buffers t)
	   (ivy-case-fold-search-default t)
	   (ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
	   (enable-recursive-minibuffers t)
	   (ivy-mode t))
  :bind (:map ivy-minibuffer-map
	      ("<RET>" . ivy-alt-done)))

(use-package counsel
  :after ivy
  :demand t
  :diminish
  :custom ((counsel-mode t))
  :bind ("C-x C-f" . counsel-find-file))

(use-package diminish
  :demand t
  :config
  (diminish 'hs-minor-mode))

(use-package pinentry
  :config
  (pinentry-start))

(use-package ivy-pass
  :config
  (global-set-key (kbd "M-p") #'ivy-pass))
