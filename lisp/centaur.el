(use-package centaur-tabs
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-bar 'over)
  (setq centaur-tabs-set-close-button nil)
  (setq centaur-tabs-cycle-scope 'tabs)
  (setq centaur-tabs-adjust-buffer-order t)
  (centaur-tabs-enable-buffer-reordering)
  
  (centaur-tabs-group-by-projectile-project)
  
  (defun centaur-tabs-buffer-groups ()
    (list
     (cond
      ((memq major-mode '(magit-process-mode
                          magit-status-mode
                          magit-diff-mode
                          magit-log-mode
                          magit-file-mode
                          magit-blob-mode
                          magit-blame-mode
                          ))
       "magit")
      ((derived-mode-p 'prog-mode)
       "prog")
      ((derived-mode-p 'dired-mode)
       "dired")
      ((derived-mode-p 'vterm-mode)
       "vterm")
      ((memq major-mode '(helpful-mode
                          help-mode))
       "help")
      (t
       (centaur-tabs-get-group-name (current-buffer)))
      )))
  )
