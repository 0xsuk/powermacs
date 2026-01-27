(use-package corfu
	:init
	(setq
	 corfu-auto t
	 corfu-auto-delay .2
	 corfu-preview-current nil
	 corfu-auto-prefix 2
	 corfu-cycle t
   corfu-count 10
	 )
	(global-corfu-mode)
	(if (not ismac) (corfu-history-mode)) ; TODO used with mac emacs shuts down
	:config
	(general-def 'corfu-map
		"C-SPC" 'corfu-insert-separator
		"RET" nil
		"C-n" 'corfu-next
		"C-p" 'corfu-previous
		"M-h" nil
		)
	
	; enabling minibuffer completion
	(defun corfu-enable-in-minibuffer ()
		"Enable Corfu in the minibuffer if `completion-at-point' is bound."
		(when (where-is-internal #'completion-at-point (list (current-local-map)))
			;; (setq-local corfu-auto nil) ;; Enable/disable auto completion
			(setq-local corfu-echo-delay nil ;; Disable automatic echo and popup
									corfu-popupinfo-delay nil)
			(corfu-mode 1)))
	(add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)
	
	; eshell
	(add-hook 'eshell-mode-hook
						(lambda ()
							(setq-local corfu-auto nil)
							(corfu-mode)))

	; sends candidate to minibuffer
	(defun corfu-move-to-minibuffer ()
		(interactive)
		(when completion-in-region--data
			(let ((completion-extra-properties corfu--extra)
						completion-cycle-threshold completion-cycling)
				(apply #'consult-completion-in-region completion-in-region--data))))
	(keymap-set corfu-map "M-m" #'corfu-move-to-minibuffer)
	(add-to-list 'corfu-continue-commands #'corfu-move-to-minibuffer)
	
	; important for lsp
	(defun my-lsp-setup-completion ()
		(setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
					'(prescient basic)))
	(add-hook 'lsp-completion-mode-hook 'my-lsp-setup-completion)
	; reason for adding basic after prescient is in prescient changelog

	
	)

;; (defun my/ignore-elisp-keywords (cand)
;;   (or (not (keywordp cand))
;;       (eq (char-after (car completion-in-region--data)) ?:)))

;; (defun my/setup-elisp ()
;;   (setq-local completion-at-point-functions
;;               `(,(cape-super-capf
;;                   (cape-capf-predicate
;;                    #'elisp-completion-at-point
;;                    #'my/ignore-elisp-keywords)
;;                   #'cape-dabbrev)
;;                 cape-file)
;;               cape-dabbrev-min-length 5))
;; (add-hook 'emacs-lisp-mode-hook #'my/setup-elisp)

(use-package cape
  :quelpa (cape :fetcher github :repo "minad/cape")
  :custom
  (cape-dabbrev-buffer-function 'my-cape-visible-buffers)
	:config
	;; (my-load-file "cape-yasnippet.el") ; too old
	;; (add-to-list 'completion-at-point-functions #'cape-yasnippet)
  

  (defun my-visible-buffers-selected-frame ()
    (delete-dups
     (mapcar #'window-buffer (window-list (selected-frame) 'no-minibuf))))
  
  (defun my-cape-visible-buffers ()
    (my-visible-buffers-selected-frame)
    )
  
  ;; (defun my-cape-magit-buffers ()
  ;;   "Return `magit-mode' buffers"
    
  ;;   (cape--buffer-list
  ;;    (lambda (buf)
  ;;      (let ((mode (buffer-local-value 'major-mode buf)))
  ;;        (provided-mode-derived-p mode #'text-mode)
  ;;        (provided-mode-derived-p mode #'magit-mode)))))

  ;; (defun my-cape-dabbrev-for-commit ()
  ;;   (setq-local cape-dabbrev-buffer-function #'my-cape-magit-and-text-buffers)
  ;;   )
  
  ;; (with-eval-after-load 'git-commit
  ;;   (add-hook 'git-commit-setup-hook #'my-cape-dabbrev-for-commit))
  
	;; (defun my-cape-for-clisp ()
		;; (setq-local completion-at-point-functions
								;; `(,(cape-super-capf
										;; (cape-capf-predicate
										 ;; #'elisp-completion-at-point
										 ;; #'my/ignore-elisp-keywords)
										;; #'cape-dabbrev)
									;; cape-file)
								;; cape-dabbrev-min-length 5
								;; )
		;; )

	; read corfu wiki!!!!
	(defun my-ignore-elisp-keywords (cand)
		(or (not (keywordp cand))
				(eq (char-after (car completion-in-region--data)) ?:)))
	(defun my-setup-elisp ()
		(setq-local completion-at-point-functions
								`(,(cape-capf-super
										(cape-capf-predicate
										 #'elisp-completion-at-point
										 #'my-ignore-elisp-keywords)
										#'cape-dabbrev)
									cape-file)
								cape-dabbrev-min-length 5
								))
	(add-hook 'emacs-lisp-mode-hook #'my-setup-elisp)
	)
