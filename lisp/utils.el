(defun my-window-transparent ()
  (interactive)
  (set-frame-parameter (selected-frame) 'alpha-background 70)
  ;; (add-to-list 'default-frame-alist '(alpha-background . 70))
  )
(defun my-window-opaque ()
  (interactive)
  (set-frame-parameter (selected-frame) 'alpha-background 100))
(defun init-lisp (name)
  "Initialize Common Lisp Project."
  (interactive "sName: ")
  (with-temp-file (expand-file-name "load.lisp")
    (insert
     (format "(pushnew (uiop:getcwd) ql:*local-project-directories*)
(ql:quickload :%s)
(asdf:load-system :%s)" name name)))
  (with-temp-file (expand-file-name (format "%s.lisp" name))
    (insert
     (format "(in-package :%s)" name)))
  (with-temp-file (expand-file-name "package.lisp")
    (insert
     (format "(defpackage :%s
  (:use
   :cl))
" name)))
  (with-temp-file (expand-file-name (format "%s.asd" name))
    (insert
     (format "(asdf:defsystem :%s
  :name \"%s\"
  :author \"0xsuk\"
  :depends-on ()
  :serial t
  :components (
               (:file \"package\")
               (:file \"%s\"))
  )
" name name name))))

(defmacro with-current-dir (dir &rest body)
  `(let ((default-directory ,dir))
     ,@body))
(defmacro my-l (&rest body)
	`(lambda () (interactive) ,@body))
(defmacro with-f12-q (&rest body)
	`(general-def 'global
		 "<f12> q" (my-l ,@body))
	)
(defun my-scroll-down ()
	(interactive)
	(scroll-up-command 7))
(defun my-scroll-up ()
	(interactive)
	(scroll-down-command 7))
(defun my-scroll-super-down ()
	(interactive)
  (let ((scroll-preserve-screen-position t))
	  (scroll-up-command 7)))
(defun my-scroll-super-up ()
	(interactive)
  (let ((scroll-preserve-screen-position t))
	(scroll-down-command 7)))
(defun hide-mode-line ()
	(interactive)
	(setq-default mode-line-format nil))
(defun hide-local-mode-line ()
	(interactive)
	(setq-local mode-line-format nil))
(defun my-next-defun ()
	(interactive)
	(beginning-of-defun -1))
(defun my-max-popper-window ()
	(interactive)
	(let ((b (buffer-name)))
		(other-window 1)
		(popper-toggle-latest)
		(switch-to-buffer b))
	)
(defun my-save-buffer ()
	(interactive)
	(unless current-prefix-arg
		(when lsp-mode
			(lsp-format-buffer))
    )
	(save-buffer))
(defun my-toggle-window-dedication ()
	(interactive)
	(set-window-dedicated-p (selected-window)
													(not (window-dedicated-p (selected-window)))))
;;make screen transparent & maximized
;; (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(defun my-text-transparent ()
	(interactive)
	;; (set-frame-parameter nil 'alpha-background 70)
	(set-frame-parameter (selected-frame) 'alpha '(60 . 60)))
(defun my-text-opaque ()
	(interactive)
	(set-frame-parameter (selected-frame) 'alpha '(100 . 100)))
(defun my-kill-all-buffers ()
	(interactive)
  (mapc 'kill-buffer (buffer-list)))
;https://emacs.stackexchange.com/questions/32958/insert-line-above-below
(defun my-insert-line-below ()
  "Insert an empty line below the current line."
  (interactive)
  (save-excursion
    (end-of-line)
    (open-line 1)))
(defun my-insert-line-above ()
  "Insert an empty line above the current line."
  (interactive)
  (save-excursion
    (end-of-line 0)
    (open-line 1)))
(defun my-isMinus ()
	"should use - or ="
	(let ((res nil))
		(dolist (mode '(emacs-lisp-mode clojure-mode eshell-mode lisp-mode vterm-mode sly-mrepl-mode shell-mode))
			(if (eq major-mode mode)
					(setq res t)))
		res
		)
	)
(defun my-split-and-move-down ()
	(interactive)
	(split-window-below)
	(windmove-down 1))
(defun my-split-and-move-right ()
	(interactive)
	(split-window-right)
	(windmove-right 1))
(defun my-insert-curly-brackets-at-end ()
	(interactive)
	(end-of-line)
	(insert " {}")
	(backward-char)
	(newline 1 t))
(defun my-insert-dot ()
	(interactive)
	(insert "->") ;TODO for C
	)
;https://qiita.com/zk_phi/items/c145b7bd8077b8a0f537

(defun my-search-space ()
	(interactive)
	(isearch-forward nil t)
	(isearch-yank-string " "))

(defun my-search-leftparen ()
	(interactive)
	(isearch-forward nil t)
	(isearch-yank-string "\("))

(defun my-search-rightparen ()
	(interactive)
	(isearch-forward nil t)
	(isearch-yank-string "\)"))

(defun my-clone (repo)
	(interactive "sRepo name: ")
	(async-shell-command (format "git clone git@github.com:0xsuk/%s.git" repo) ))

(defun my-strand (sequence)
	"Downcase SEQUENCE and substitute space to -.  save it to kill ring."
	(interactive "sStrand: ")
	(kill-new (downcase (cl-substitute ?\- ?\s sequence))))

(defun my-rosalind-file (sequence)
	"Create a new file by downcasing SEQUENCE and substituting space to -."
	(interactive "sStrand: ")
	(let ((minibuffer-setup-hook
				 (lambda ()
					 (insert (concat (downcase (cl-substitute ?\- ?\s sequence))
													 ".lisp")))))
		(call-interactively 'find-file))
	)
