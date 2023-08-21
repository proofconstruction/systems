;; keybinding for easily checking mail
(global-set-key (kbd "M-M")  'mu4e)

;; don't send mail when I C-c C-c accidentally
(add-hook 'message-send-hook
  (lambda ()
    (unless (yes-or-no-p "Are you sure you want to send this?")
      (signal 'quit nil))))

;; (defun my-mu4e-set-account ()
;;   "Set the account for composing a message."
;;   (let* ((account
;;           (if mu4e-compose-parent-message
;;               (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
;;                 (string-match "/\\(.*?\\)/" maildir)
;;                 (match-string 1 maildir))
;;             (completing-read (format "Compose with account: (%s) "
;;                                      (mapconcat #'(lambda (var) (car var))
;;                                                 my-mu4e-account-alist "/"))
;;                              (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
;;                              nil t nil nil (caar my-mu4e-account-alist))))
;;          (account-vars (cdr (assoc account my-mu4e-account-alist))))
;;     (if account-vars
;;         (mapc #'(lambda (var)
;;                   (set (car var) (cadr var)))
;;               account-vars)
;;       (error "No email account found"))))

;; ;; ask for account when composing mail
;; (add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

;; ;; enable multi-account usage
;; (setq mu4e-user-mail-address-list
;;       (mapcar (lambda (account) (cadr (assq 'user-mail-address account)))
;;               my-mu4e-account-alist))

;; mu4e config
(setq

 ;; viewing
 ;; include full message threads
 ;; mu4e-search-include-related t

 ;; updating
 ;; pull new mail
 mu4e-get-mail-command "mbsync -a"
 ;; there is already a system service to auto-sync mail and update mu's database
 mu4e-update-interval nil
 ;; don't update without interaction
 mu4e-index-update-in-background nil

 ;; sending
 ;; use msmtp
 sendmail-program "msmtp"
 ;; use smtpmail to send
 send-mail-function 'smtpmail-send-it
 ;; i don't know why i'm setting this when i have the previous variable set
 ;; but that's the beauty of cargo-culting: i don't have to know why!
 message-send-mail-function 'message-send-mail-with-sendmail
 ;; this should do the same thing as the next one
 message-sendmail-extra-arguments '("--read-envelope-from")
 ;; use the address that received the mail as the sending address
 message-sendmail-envelope-from 'header
 ;; don't pass `-f <username>` to the sendmail command line
 message-sendmail-f-is-evil t
 ;; don't keep message buffers around after sending
 message-kill-buffer-on-exit t

 ;; misc
 ;; don't show previous messages in the thread
 mu4e-search-include-related nil
 ;; save attachments here
 mu4e-attachment-dir "~/mail/attachments"
 ;; attempt to show images when viewing messages
 mu4e-view-show-images t

 ;; don't confirm on quit; i can always hit M-M again
 mu4e-confirm-quit nil

 ;; use mu4e to read and write mails
 mail-user-agent 'mu4e-user-agent
 read-mail-command 'mu4e)
