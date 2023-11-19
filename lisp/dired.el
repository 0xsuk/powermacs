(use-package dired
	; use find-file to fuzzy search in dired
  :ensure nil
  :custom
  (dired-listing-switches "-AFl --group-directories-first")
  :config
  ;(add-hook 'dired-mode-hook 'auto-revert-mode)
	(setq dired-auto-revert-buffer t)
	;; (setq dired-kill-when-opening-new-dired-buffer t) ; no need for dired-single
	(setq dired-dwim-target t) ; for multiple dired window copy support

	(general-def dired-mode-map
		"j" 'dired-next-line
		"k" 'dired-previous-line
		"l" 'dired-find-file ; use find-file-other-window for files, with ace-window
		"h" 'dired-up-directory
		"f" 'dired-create-empty-file
		"r" 'dired-do-rename
		"m" 'dired-mark
		"U" 'dired-unmark-all-marks
		"u" 'dired-unmark
		"d" 'dired-do-delete
		"+" 'dired-create-directory
		"M-s" nil
		)
	)
