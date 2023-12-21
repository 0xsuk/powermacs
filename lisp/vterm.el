;; (defun my-vterm-directory-sync ()
;;   "Synchronize current working directory."
;;   (interactive)
;;   (when vterm--process
;;     (let* ((pid (process-id vterm--process)) ;
;;            (dir (file-truename (format "/proc/%d/cwd" pid))))
;;       (unless (string= dir "/")
;; 	(setq dir (concat dir "/")))
;;       (setq-local default-directory dir))))

(use-package vterm
  :defer 1
	:config
	; https://www.reddit.com/r/emacs/comments/ovkyov/vterm_completion_for_files_directories_command/
	(defun my-vterm-history ()
		(interactive)
		(vterm-send-string
																				; you must
		 ;; shopt -s histappend
		 ;; PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
		 ;; in bashrc
		 (completing-read "History: " (with-temp-buffer
																	(insert-file-contents "~/.bash_history")
																	(split-string (buffer-string) "\n" t)))))
	(defun my-vterm-command ()
		(interactive)
		(vterm-send-string
		 (completing-read "Command: " (split-string (shell-command-to-string "compgen -c") "\n" t ))))
	(defun my-vterm-files ()
		(interactive)
		(vterm-send-string
		 (completing-read "Files: " (split-string (shell-command-to-string "compgen -f") "\n" t ))))
	(general-def vterm-copy-mode-map
		"C-c C-w" 'vterm-narrow-to-output
		)
	(general-def vterm-mode-map
		"C-c C-h" (my-l (vterm-send-string "cd ..\n"))
		"C-c C-j" (my-l (vterm-send-string "cd ~\n"))
		"C-c C-k" (my-l (vterm-send-string "cd -\n"))
    "C-v" nil
		"C-]" nil
		"C-z" nil
		"C-t" nil
    "C-h" nil
    "C-l" nil
		; in vterm mark commands do not work
		"M-l" nil
    "M-p" 'vterm-send-C-p
    "M-n" 'vterm-send-C-n
		"M-h" nil
		"M-j" nil
		"M-k" nil
		"M-w" nil
		"M-s" nil
		"M-m" 'my-vterm-min
		;;	"C-\\" nil ; Does not work
		"M-q" nil
		"C-@" nil
		"C-^" nil
		"M-r" 'my-vterm-history
		"M-c" 'my-vterm-command
		"M-o" 'my-vterm-files ; use find-file insert
		"M-:" nil
		"<f12>" nil
		"<C-backspace>" (my-l (vterm-send-key (kbd "C-w")))
		";"
		(general-key-dispatch 'vterm--self-insert
			;; :timeout 0.35
			"e" (my-l (end-of-line) (vterm-send-C-e) (vterm-send-string ";"))
			" " (my-l (vterm-send-string ";"))
			"w" (my-l (vterm-send-string "'"))
			"f" (my-l (vterm-send-string "()") (vterm-send-C-b))
			"s" (my-l (vterm-send-string "\"\"") (vterm-send-C-b))
			"a" (my-l (vterm-send-string "&")) ; pointer
			"t" (my-l (vterm-send-string "%"))
			;; "u" 'my-vterm-send-string-dot
			;; "c" 'my-vterm-send-string-curly-brackets-at-end
			;; "d" 'my-vterm-send-string-dot
			"r" (my-l (vterm-send-string "#"))
			;; ";" (general-key-dispatch 'self-vterm--send-string-command
			;; "")
			)
		)
	(defun my-vterm-min ()
		(interactive)
		(setq-local vterm-min-window-width (window-width)) ; for peaclock
		(setq-local cursor-in-non-selected-windows nil)
		)
  )
(defun my-toggle-vterm ()
  "Toggle multi-vterm window."
  (interactive)
  (unless (catch 'vterm-loop
    (dolist (buffer multi-vterm-buffer-list)
      (let ((window (get-buffer-window buffer)))
				(when window
					(delete-window window)
					(throw 'vterm-loop t))))
    )
		(my-split-and-move-down)
    (evil-window-set-height 20)
    (multi-vterm-next)))
(defun vterm--select-output ()
	(let (start end)
		(vterm-previous-prompt 1)
		(next-line 1)
		(beginning-of-line)
		(setq start (point))
		(set-mark start)
		(vterm-next-prompt 1)
		(previous-line 1)
		(end-of-line)
		(setq end (point))
		`(,start ,end))
	)
(defun vterm-narrow-to-output ()
	(interactive)
	(let* ((mark (vterm--select-output))
				 (start (car mark))
				 (end (cadr mark)))
		(narrow-to-region start end)
		)
	)


;; (use-package multi-vterm
  ;; :config
;; ) ; always creates new even when one is avaiable
