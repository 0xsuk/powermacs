;; (defun my-vterm-directory-sync ()
;;   "Synchronize current working directory."
;;   (interactive)
;;   (when vterm--process
;;     (let* ((pid (process-id vterm--process)) ;
;;            (dir (file-truename (format "/proc/%d/cwd" pid))))
;;       (unless (string= dir "/")
;; 	(setq dir (concat dir "/")))
;;       (setq-local default-directory dir))))



;;NOTE: add this line to vterm for better M-r
;;PROMPT_COMMAND='history -a; history -n; '"${PROMPT_COMMAND}"

(use-package vterm
  :defer 1
	:config
	; https://www.reddit.com/r/emacs/comments/ovkyov/vterm_completion_for_files_directories_command/
  (setq vterm-timer-delay nil) ; snappy!
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
    "C-o" (my-l
            (dired default-directory))
		; in vterm mark commands do not work
		"M-l" nil
    "M-9" nil
    "M-0" nil
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

(defun my-dired-then-vterm (dir)
  "Open DIR in dired, then open vterm in that directory."
  (interactive "DDirectory: ")
  ;; まず dired バッファへ
  (dired dir)
  ;; その dired バッファの default-directory を使って vterm
  (let ((default-directory dir))
    (my-multi-vterm)))

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

(defun vterm-find-some ()
  (cl-loop for buf in (buffer-list)
           if (with-current-buffer buf
                (eq major-mode 'vterm-mode))
           return buf))

(defun in-vterm? ()
  (eq major-mode 'vterm-mode)
  )

(defun no-vterm-buffer? ()
  (eq multi-vterm-buffer-list nil))
;; Use `pop-to-buffer' instead of `switch-to-buffer'

(defun create-new-multi-vterm (dir)
  
  (with-temp-buffer
    (cd dir)
    
    (let ((vterm-buffer (multi-vterm-get-buffer)))
      (setq multi-vterm-buffer-list
            (nconc multi-vterm-buffer-list (list vterm-buffer)))
      (set-buffer vterm-buffer)
      (multi-vterm-internal)
      (pop-to-buffer vterm-buffer)))
  )

(defun my-multi-vterm ()
  "Create new vterm buffer."
  (interactive)
  (message "pending? %s" find-file-pending)
  (if find-file-pending
      (create-new-multi-vterm ))
  (if (derived-mode-p 'magit-status-mode)
      
    (dired magit--default-directory))
  (if (or  (in-vterm?) (no-vterm-buffer?))
      (create-new-multi-vterm default-directory)
                                        ; not in vterm, and some vterm buffer exist
    (if current-prefix-arg ; always create new vterm regardless?
        (create-new-multi-vterm default-directory)
      ;; C-u無し: 既存のvtermバッファに移動
      (pop-to-buffer (vterm-find-some)))))

(use-package multi-vterm
  :after vterm
  :config
  (advice-add #'multi-vterm :override #'my-multi-vterm)
) ; always creates new even when one is avaiable
