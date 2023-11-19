(use-package magit
  :defer t
  :custom
  (magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1) ; show in full window
  :config
	(general-def magit-status-mode-map
		"q" (my-l (magit-restore-window-configuration))
		)
	;; (general-def magit-hunk-section-map
	;; 	"C-j" nil
	;; 	"C-k" nil)
	(add-hook 'git-commit-setup-hook (my-l (setq-local cape-dabbrev-check-other-buffers t)))
	
  )
