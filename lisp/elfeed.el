(use-package elfeed
  :defer t
	:config
	(setq elfeed-search-filter "@6-months-ago")
	(setq elfeed-db-directory (expand-file-name "elfeed" user-emacs-directory)
				;; elfeed-show-entry-switch 'display-buffer
				))

(use-package elfeed-org
  :defer t
	:after elfeed
	:config
	(elfeed-org)
	(setq rmh-elfeed-org-files (mapcar (lambda (file) (expand-file-name file elfeed-db-directory)) '("news.org" "blogs.org")))
	)
