(defun my-eshell-grab-output ()
	(interactive)
	(eshell-previous-prompt 1)
	(next-line 1)
	(eshell-bol)
	(evil-visual-char)
	(eshell-next-prompt 1)
	(previous-line 1)
	(end-of-line))

(defun my-eshell-or-projectile-eshell () 
	"Run eshell or projectile-run-eshell."
	(interactive)
  (unless projectile-mode (projectile-mode))
	(if (eq current-prefix-arg nil) 
			(if (projectile-project-p)
					(projectile-run-eshell)
				(eshell))
		(if (projectile-project-p)
				(projectile-run-eshell 'N)
			(eshell 'N))
		)
	)


(use-package eshell
  :defer t
	:ensure nil
	:init
	(setq eshell-hist-ignoredups t)
	(setenv "PAGER" "cat") ; suppresses WARNING: terminal is not fully functional
	:config
  (general-def eshell-hist-mode-map
    "M-s" nil
    "M-r" 'consult-history
    )
  (general-def eshell-mode-map
    "C-c <C-i>" (my-l (end-of-buffer) (meow-insert)))
  ; C-c M-o is good, prefix with C-u narrows region
  
	(add-hook 'eshell-mode-hook
						(lambda ()
							(message "exe")
							; this slows down single command completion
							;; (defun eshell--complete-commands-list ();https://github.com/company-mode/company-mode/issues/1322
							;; 	"Generate list of applicable, visible commands."
							;; 	(let ((filename (pcomplete-arg)) glob-name)
							;; 		(if (file-name-directory filename)
							;; 				(if eshell-force-execution
							;; 						(pcomplete-dirs-or-entries nil #'file-readable-p)
							;; 					(pcomplete-executables))
							;; 			(if (and (> (length filename) 0)
							;; 							 (eq (aref filename 0) eshell-explicit-command-char))
							;; 					(setq filename (substring filename 1)
							;; 								pcomplete-stub filename
							;; 								glob-name t))
							;; 			(let* ((paths (eshell-get-path))
							;; 						 (cwd (file-name-as-directory
							;; 									 (expand-file-name default-directory)))
							;; 						 (path "") (comps-in-path ())
							;; 						 (file "") (filepath "") (completions ()))
							;; 				;; Go thru each path in the search path, finding completions.
							;; 				(while paths
							;; 					(setq path (file-name-as-directory
							;; 											(expand-file-name (or (car paths) ".")))
							;; 								comps-in-path
							;; 								(and (file-accessible-directory-p path)
							;; 										 (file-name-all-completions filename path)))
							;; 					;; Go thru each completion found, to see whether it should
							;; 					;; be used.
							;; 					(while comps-in-path
							;; 						(setq file (car comps-in-path)
							;; 									filepath (concat path file))
							;; 						(if (and (not (member file completions)) ;
							;; 										 (or (string-equal path cwd)
							;; 												 (not (file-directory-p filepath)))
							;; 										 (if eshell-force-execution
							;; 												 (file-readable-p filepath)
							;; 											 (file-executable-p filepath)))
							;; 								(setq completions (cons file completions)))
							;; 						(setq comps-in-path (cdr comps-in-path)))
							;; 					(setq paths (cdr paths)))
							;; 				;; Add aliases which are currently visible, and Lisp functions.
							;; 				(pcomplete-uniquify-list
							;; 				 (if glob-name
							;; 						 completions
							;; 					 (setq completions
							;; 								 (append (if (fboundp 'eshell-alias-completions)
							;; 														 (eshell-alias-completions filename))
							;; 												 (eshell-winnow-list
							;; 													(mapcar
							;; 													 (lambda (name)
							;; 														 (substring name 7))
							;; 													 (all-completions (concat "eshell/" filename)
							;; 																						obarray #'functionp))
							;; 													nil '(eshell-find-alias-function))
							;; 												 completions))
							;; 					 (append (and (or eshell-show-lisp-completions
							;; 														(and eshell-show-lisp-alternatives
							;; 																 (null completions)))
							;; 												(all-completions filename obarray #'functionp))
							;; 									 completions)))))))
							)))
