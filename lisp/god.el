(use-package god-mode
	:init
	(god-mode)
	:config
	(general-def 'global
		"<escape>" 'god-local-mode))

(defun my-god-mode-update-cursor-type ()
	(setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))

(add-hook 'post-command-hook #'my-god-mode-update-cursor-type)
