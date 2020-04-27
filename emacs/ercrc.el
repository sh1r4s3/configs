;;  Authentication
(setq erc-prompt-for-password nil)
(global-set-key "\C-cef" (lambda () (interactive)
                (erc :server "irc.freenode.net" :full-name "Nikita Ermakov" :nick "sh1r4s3")))

;; Autojoin
(setq erc-autojoin-channels-alist '(("freenode.net" "#emacs" "#erc" "#programming" "#gentoo" "#linux" "#riscv")))

;; Rename server buffers to reflect the current network name instead
;; of SERVER:PORT (e.g., "freenode" instead of "irc.freenode.net:6667").
;; This is useful when using a bouncer like ZNC where you have multiple
;; connections to the same server.
(setq erc-rename-buffers t)

;; Interpret mIRC-style color commands in IRC chats
(setq erc-interpret-mirc-color t)

;; The following are commented out by default, but users of other
;; non-Emacs IRC clients might find them useful.
;; Kill buffers for channels after /part
;; (setq erc-kill-buffer-on-part t)
;; Kill buffers for private queries after quitting the server
;; (setq erc-kill-queries-on-quit t)
;; Kill buffers for server messages after quitting the server
;; (setq erc-kill-server-buffer-on-quit t)
