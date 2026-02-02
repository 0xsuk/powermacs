(use-package magit
  :quelpa (magit :fetcher github :repo "magit/magit" :commit "c800f79c2061621fde847f6a53129eca0e8da728")
  :defer t
  :custom
  (magit-diff-visit-prefer-worktree t) ; do not open in * index *
  (magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1) ; show in full window
  :config
	(general-def magit-status-mode-map
		"q" (my-l (magit-restore-window-configuration))
		)
	;; (general-def magit-hunk-section-map
	;; 	"C-j" nil
	;; 	"C-k" nil)
	(add-hook 'git-commit-setup-hook (my-l (setq-local cape-dabbrev-check-other-buffers t)))
  (setq magit-log-section-commit-count 20)
  (setq-default magit-log--color-graph t)
	


  (put 'magit-log-mode 'magit-log-default-arguments
     '("--graph" "-n256" "--decorate" "--color")) ; add color arg to default (unofficial way)
  )
