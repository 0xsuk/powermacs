;; (use-package shackle
	;; :config
	;; (setq shackle-default-rule
				;; '(:same t)))

(use-package popper
	:config
	(setq popper-reference-buffers
				'("\\*Messages\\*"
					"Output\\*$"
					eshell-mode
					"^\\*eshell.*\\*$"
					vterm-mode
					"^\\*vterminal.*\\*$"
					shell-mode
					"^\\*shell.*\\*$"
					;; dired-mode
					help-mode
					helpful-mode
					sly-db-mode ; sly debug mode
					"^\\*sly-db.*"
          "^\\*sly-traces.*"
          "^\\*sly-stickers.*"
					"\\*xref\\*"
					"\\*Backtrace\\*"
					"^\\*Embark Collect.*"
					compilation-mode
					"^\\*sly-description*\\*$"
					point-history-show-mode
					;; Man-mode
					"^EAF Music Player$"
					"*eww*"
					))
	(setq popper-window-height 0.5)
	(popper-mode 1)
	)
