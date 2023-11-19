(use-package counsel
  :config
  (setq ivy-initial-inputs-alist nil); Don't start searchs with ^
	) 

(use-package counsel-projectile ; make sure ripgrep is installed. rg is great
  :demand t
  :config
  (counsel-projectile-mode)
  (counsel-projectile-modify-action
   'counsel-projectile-switch-project-action
   '((default counsel-projectile-switch-project-action-dired)))
  )
