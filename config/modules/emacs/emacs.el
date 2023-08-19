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
(load "~/.emacs.d/emacs-anywhere.el")


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
(display-time-mode t)


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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FONTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun font-exists-p (font)
  "Check if the font exists."
  (and (display-graphic-p) (not (null (x-list-fonts font)))))

(defun set-preferred-fonts (font-size)
  (cond
   ((font-exists-p "Source Code Pro")
    (set-face-attribute 'fixed-pitch nil :family "Source Code Pro" :height font-size)
    (set-face-attribute 'default nil :family "Source Code Pro" :height font-size)))

  (cond
   ((font-exists-p "Ubuntu")
    (set-face-attribute 'variable-pitch nil :family "Ubuntu" :height font-size))))

(set-preferred-fonts 150)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PERFORMANCE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Increase garbage collection threshold for lsp-mode
(setq gc-cons-threshold 100000000)

;; Increase data Emacs reads from the process
(setq read-process-output-max (* 1024 1024)) ;; 1mb


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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MISC CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Don't want to move based on visual line.
(setq line-move-visual nil)

;; Stop creating backup and autosave files.
(setq make-backup-files nil
      auto-save-default nil)

;; Confirm to kill Emacs
(setq confirm-kill-emacs #'yes-or-no-p)

;; Alias to enable single keypress confirm or deny
(defalias 'yes-or-no-p 'y-or-n-p)

;; Always show line and column number in the mode line.
(line-number-mode)
(column-number-mode)

;; Only indent 2 spaces
(setq standard-indent 2)

;; Highlight end-of-line whitespace
(setq-default show-trailing-whitespace t)

;; I typically want to use UTF-8.
(prefer-coding-system 'utf-8)

;; Nicer handling of regions.
(transient-mark-mode 1)

;; Make moving cursor past bottom only scroll a single line rather
;; than half a page.
(setq scroll-step 1
      scroll-conservatively 5)

;; Show line numbers in the sidebar in any programming mode
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Make xelatex the default run command for latex compilation
(setq latex-run-command "xelatex")
;; word wrap when working on latex
(add-hook 'latex-mode-hook #'visual-line-mode)

;; Enable visual-line-mode and org-indent-mode for org-mode files
(with-eval-after-load 'org
 (setq org-startup-indented t)
 (add-hook 'org-mode-hook #'visual-line-mode))

;; Enable org-exporting org-mode files
(setq org-export-backends '(org html latex))

;; Enable tramp for ssh
(setq tramp-default-method "ssh")

;; Tabs should be 4 spaces.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LANGUAGE PACKAGES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package lsp-mode
  ;; :disabled t
  :commands (lsp)
  :hook (rust-mode . lsp)
  :config
  (setq lsp-prefer-flymake nil))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-show-hover t
        lsp-inlay-hint-enable t
        global-display-line-numbers-mode t))

(use-package lsp-mode
  :after (direnv)
  :commands (lsp)
  :hook ((haskell-mode . lsp-deferred)
	     (rust-mode . lsp-deferred))
  :custom
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (setq lsp-prefer-flymake nil)
  ; Optional, I don't like this feature
  (setq lsp-enable-snippet nil)
  ; LSP will watch all files in the project
  ; directory by default, so we eliminate some
  ; of the irrelevant ones here, most notable
  ; the .direnv folder which will contain *a lot*
  ; of Nix-y noise we don't want indexed.
  (setq lsp-file-watch-ignored '(
    "[/\\\\]\\.direnv$"
    ; SCM tools
    "[/\\\\]\\.git$"
    "[/\\\\]\\.hg$"
    "[/\\\\]\\.bzr$"
    "[/\\\\]_darcs$"
    "[/\\\\]\\.svn$"
    "[/\\\\]_FOSSIL_$"
    ; IDE tools
    "[/\\\\]\\.idea$"
    "[/\\\\]\\.ensime_cache$"
    "[/\\\\]\\.eunit$"
    "[/\\\\]node_modules$"
    "[/\\\\]\\.fslckout$"
    "[/\\\\]\\.tox$"
    "[/\\\\]\\.stack-work$"
    "[/\\\\]\\.bloop$"
    "[/\\\\]\\.metals$"
    "[/\\\\]target$"
    ; Autotools output
    "[/\\\\]\\.deps$"
    "[/\\\\]build-aux$"
    "[/\\\\]autom4te.cache$"
    "[/\\\\]\\.reference$")))

(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  ;; (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (add-hook 'before-save-hook 'lsp-format-buffer nil t))

(use-package lsp-haskell
  :after haskell-mode lsp-mode)

(use-package haskell-mode
  :init
  (setq haskell-mode t))

(use-package svelte-mode)

(use-package go-mode)

(use-package terraform-mode)

(use-package markdown-mode
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
    (add-hook 'markdown-mode-hook 'visual-line-mode)))

(use-package dockerfile-mode)
(use-package yaml-mode)

(use-package json-mode)

(use-package nix-mode)
(use-package nixpkgs-fmt
  :init
  (add-hook 'nix-mode-hook 'nixpkgs-fmt-on-save-mode))
(use-package typescript-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MISC PACKAGES
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FUNCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun insert-current-date ()
  (interactive)
  (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
