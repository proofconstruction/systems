{ config
, lib
, ...
}:

let

  mailSectionHeader = ''
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; MAIL
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  '';

  loadMu4e = ''
    ;; Make sure mu is available
    (add-to-list 'load-path "~/.nix-profile/share/emacs/site-lisp/mu4e")
    (require 'mu4e)
  '';

  mu4eBaseConfig = builtins.readFile ./mu4e.el;

  contextHeader = ''
    (setq mu4e-contexts
    `(
  '';

  contextFooter = "))";

  gmailPredicate = flavor: if flavor == "gmail.com" then true else false;

  mkSentFolder = account: flavor: "/${account}" + (if gmailPredicate flavor then "/[Gmail]/Sent Mail" else "/Sent");
  mkDraftsFolder = account: flavor: "/${account}" + (if gmailPredicate flavor then "/[Gmail]/Drafts" else "/Drafts");
  mkTrashFolder = account: flavor: "/${account}" + (if gmailPredicate flavor then "/[Gmail]/Trash" else "/Trash");
  mkRefileFolder = account: flavor: "/${account}" + (if gmailPredicate flavor then "/[Gmail]/Important" else "/Archive");

  mkMu4eContext = name: cfg: ''
    ,(make-mu4e-context
      :name "${name}"
      :match-func (lambda (msg) (when msg
                                  (string-prefix-p "${name}" (mu4e-message-field msg :maildir))))
      :vars '(
              (user-full-name . "${cfg.fullName}")
              (user-mail-address . "${cfg.address}")
              (mu4e-sent-folder . "${mkSentFolder name cfg.flavor}")
              (mu4e-drafts-folder . "${mkDraftsFolder name cfg.flavor}")
              (mu4e-trash-folder .  "${mkTrashFolder name cfg.flavor}")
              (mu4e-refile-folder . "${mkRefileFolder name cfg.flavor}")
              (mu4e-maildir-shortcuts . (("/INBOX" . ?i)
                                         ("/Archive" . ?a)
                                         ("/Sent" . ?s)
                                         ("/Trash" . ?t)
                                         ("/Junk" . ?j)))))
  '';

  mailAccounts = config.private.email;

  contextBody = lib.concatLines (lib.mapAttrsToList mkMu4eContext mailAccounts);

  mkUnifiedInboxSummand = name: cfg: "maildir:/${name}/Inbox";
  unifiedInboxQuery = lib.concatStringsSep " OR " (lib.mapAttrsToList mkUnifiedInboxSummand mailAccounts);
  unifiedInbox = ''
    (add-to-list 'mu4e-bookmarks
      '( :name  "Unified Inbox"
         :query "${unifiedInboxQuery}"
         :key   ?I))
  '';

in
{
  config.custom.emacs.configExtra = [
    mailSectionHeader
    loadMu4e
    mu4eBaseConfig
    contextHeader
    contextBody
    contextFooter
    unifiedInbox
  ];
}
