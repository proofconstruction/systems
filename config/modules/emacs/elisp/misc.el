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
