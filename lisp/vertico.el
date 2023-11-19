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

(use-package vertico
  :config
  (setq vertico-count 10)
	(general-def vertico-map
		"C-<backspace>" 'dw/minibuffer-backward-kill
    "M-h" 'vertico-go-home
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

