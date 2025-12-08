;TODO
;embark-act : with-current-dir asyncshellcommand

;; (defun my-vterm-cd-insert (dir &optional wildcards)
;; 	(interactive)
;; 	(vterm-send-string (concat "cd " dir "\n")))

;; (defun my-embark-vterm-cd ()
;; 	(interactive)
;; 	(with-demoted-errors "%s"
;; 		(call-interactively 'my-vterm-cd-insert)))

(defmacro my-embark-ace-action (fn)
	`(defun ,(intern (concat "my-embark-ace-" (symbol-name fn))) ()
		 (interactive)
		 (with-demoted-errors "%s"
			 (require 'ace-window)
			 (let ((aw-dispatch-always t))
				 (aw-switch-to-window (aw-select nil))
				 (call-interactively (symbol-function ',fn))))))

(setq-local embark-insert 'embark-insert) ; call this with funcall
(defun embark-insert (strings)
	(if (eq major-mode 'vterm-mode)
			(vterm-send-string (car strings))
		(funcall embark-insert strings)))

; TODO this creates new buffer
(defun my-embark-preview ()
	(interactive)
	(unless (bound-and-true-p consult--preview-function)
		(save-selected-window
			(let ((embark-quit-after-action nil))
				(embark-dwim)))))

(use-package embark
	:config
	(general-def 'global
		"C-<return>" 'embark-dwim ; good alternative to M-. find def
		"C-h B" 'embark-bindings
		)
	(general-def vertico-map
		"C-<return>" 'vertico-exit-input
		"C-o" 'embark-act
		"C-SPC" 'embark-export 
		;; "M-." 'my-embark-preview
		)
	(general-def embark-file-map
    "e" 'eshell
    "v" (lambda (dir)
          (create-new-multi-vterm dir))

		"o" (my-embark-ace-action find-file))
	(general-def embark-buffer-map
		"o" (my-embark-ace-action switch-to-buffer)
		)
	(general-def embark-bookmark-map
		"o" (my-embark-ace-action bookmark-jump))

	;; (defun my-quit-minibuffer-when-collect ()
		;; (with-selected-window (active-minibuffer-window)
			;; (minibuffer-keyboard-quit))
		;; )
	)

(use-package embark-consult
	:hook
	(embark-collect-mode . consult-preview-at-point-mode) ; TODO ?
	)

