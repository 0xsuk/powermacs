;; ; WINDOW MANAGEMENT
(use-package window-purpose
  :defer t
	:init
	;; (purpose-mode 1)
	(add-to-list 'purpose-user-mode-purposes '(fireplace-mode . fireplace))
	(add-to-list 'purpose-user-name-purposes '("*clock*" . clock))
	(add-to-list 'purpose-user-mode-purposes '(shell-mode . terminal))
	(add-to-list 'purpose-user-mode-purposes '(vterm-mode . terminal))

	;; (setq switch-to-buffer-obey-display-actions t)
	
	;; (purpose-x-popwin-setup)
	;; (setq purpose-x-popwin-major-modes '(help-mode helpful-mode compilation-mode occur-mode dired-mode vterm-mode shell-mode eshell-mode)) ; TODO https://github.com/bmag/emacs-purpose/blob/bb462f12f836414425edac32ebd069b4fd5b98d4/window-purpose.el#L262
	;; (setq purpose-x-popwin-buffer-name-regexps '("^\\*eshell.*\\*$" "^\\*vterm.*\\*$"))
	;; (purpose-x-popupify-purpose 'terminal #'purpose-display-at-bottom) ; https://github.com/bmag/emacs-purpose/blob/dc4f8a00a8b0c1cf6242e1bf47f82e08c508a51e/window-purpose-x.el#L545
	;; (purpose-x-popwin-update-conf)
	(purpose-compile-user-configuration)
	)


(defun my-load-window-layout ()
		"enable purpose mode temporarily"
		(interactive)
		(purpose-mode +1)
		(purpose-load-window-layout)
		(purpose-mode -1)
		)
(defun my-save-window-layout ()
		"enable purpose mode temporarily"
		(interactive)
		(purpose-mode +1)
		(call-interactively
		 'purpose-save-window-layout)
		(purpose-mode -1))
