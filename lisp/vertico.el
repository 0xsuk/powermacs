(defun dw/minibuffer-backward-kill (arg)
  "When minibuffer is completing a file name delete up to parent
folder, otherwise delete a character backward"
  (interactive "p")
  (if minibuffer-completing-file-name
      ;; Borrowed from https://github.com/raxod502/selectrum/issues/498#issuecomment-803283608
      (if (string-match-p "/." (minibuffer-contents))
          (zap-up-to-char (- arg) ?/)
        (delete-minibuffer-contents))
    (backward-kill-word 1)))

(defun vertico-go-home ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line 1)
  (insert "~/"))

(defvar-local myvertico-index 0) ;used to prevent group cycling
(defvar myvertico-cycle-group nil)
(defun out-of-list (n list)
  (if (or (< n 0) (>= n (length list)))
      t
    nil)
  )
(use-package vertico
  :config
  (defun vertico-next-group (&optional n)
    "Cycle N groups forward.
When the prefix argument is 0, the group order is reset."
    (interactive "p")
    (let ((next-index (+ myvertico-index n)))
      (when (cdr vertico--groups)
        (if (setq vertico--lock-groups (not (eq n 0)))
            (setq vertico--groups (vertico--cycle vertico--groups
                                                  (if (and (not myvertico-cycle-group) (out-of-list next-index vertico--groups))
                                                      0
                                                    (let ((len (length vertico--groups)))
                                                      (setq myvertico-index next-index)
                                                      (- len (mod (- n) len))
                                                      )))
                  vertico--all-groups (vertico--cycle vertico--all-groups
                                                      (seq-position vertico--all-groups
                                                                    (car vertico--groups))))
          (setq vertico--groups nil
                vertico--all-groups nil))
        (setq vertico--lock-candidate nil
              vertico--input nil))))
  
  (setq vertico-count 15)
  
	(general-def vertico-map
		"C-<backspace>" 'dw/minibuffer-backward-kill
    "C-j" 'dw/minibuffer-backward-kill
    "C-k" 'vertico-insert
    "C--" 'vertico-go-home
		;; (defun my-embark-insert (strings)
			;; (interactive)
			;; (if (eq major-mode 'vterm-mode)
					;; (vterm-send-string strings)
				;; (embark-insert strings))
			;; )
		;; "C-i" 'my-embark-insert
		;; "C-j" 'vertico-next
		;; "C-k" 'vertico-previous
		"C-n" 'vertico-next
		"C-p" 'vertico-previous
		"C-S-n" 'vertico-next-group
		"C-S-p" 'vertico-previous-group
		;; "C-n" 'vertico-next-group
		;; "C-p" 'vertico-previous-group
		"C-u C-p" 'vertico-last
		"C-u C-n" 'vertico-first
    "M-." 'embark-collect
		)
  (vertico-mode))

(use-package savehist
	:init
	(savehist-mode))

(setq enable-recursive-minibuffers t)

