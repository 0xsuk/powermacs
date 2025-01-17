(use-package golden-ratio
  :config
  ;; (golden-ratio-mode)
  )

; M-x esup
(use-package esup)

(use-package exec-path-from-shell ; needed for lsp to work properly
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package paredit
	)

(use-package expand-region
	)

(use-package crux
  :defer 1
	)

(use-package undo-tree
  :init
  (global-undo-tree-mode 1)
	(setq undo-tree-visualizer-diff t
				undo-tree-visualizer-timestamps t)
  :config
  ;; (evil-set-undo-system 'undo-tree) ; setq is not working don't know why
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))) ; TODO not working
	(general-def undo-tree-map
		"C-/" nil
    "C-?" nil))

(use-package imenu-anywhere)

(use-package projectile ; automatically detects ivy and use it
  :defer t
  :init
  ;; (setq projectile-project-search-path '("~/go/src/github.com/0xsuk"))
  (setq projectile-sort-order 'recentf)
  :config
  (projectile-mode)
	)
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))
(use-package helpful
  :defer 1
  :config
	(general-def 'global
		"C-h f" #'helpful-callable
		"C-h v" #'helpful-variable
		"C-h k" #'helpful-key
		"C-h x" #'helpful-command)
	)

(use-package flycheck
  :defer 1
	:init
	(global-flycheck-mode)
	(setq flycheck-display-errors-delay 0.5)


  (general-def flycheck-mode-map
    "C-c n" 'flycheck-next-error
    "C-c p" 'flycheck-previous-error
    "C-c l" 'flycheck-list-errors
    )
  )

(use-package command-stats
  :quelpa (command-stats :fetcher github :repo "0xsuk/command-stats.el"))

;; (use-package char-stats
;; 	:quelpa (char-stats :fetcher github :repo "0xsuk/char-stats.el"))

;; (use-package point-history
;;   :defer t
;; 	:quelpa (point-history :fetcher github :repo "blue0513/point-history")
;; 	:config
;; 	(point-history-mode)
;; 	(setq point-history-should-preview nil
;; 				point-history-show-buffer-height 10)
;; 	)

(use-package command-log-mode
  :defer t
	)

(use-package yasnippet ; company completion support
	:hook (prog-mode . yas-minor-mode)
	:config
	(yas-reload-all)
  (general-def yas-minor-mode-map
    "<tab>" nil
    "TAB" nil
    "<backtab>" 'yas-expand
    "C-<tab>" 'yas-next-field-or-maybe-expand
    "C-<iso-lefttab>" 'yas-prev-field)
  (general-def yas-keymap
    "<tab>" nil
    "TAB" nil
    "<backtab>" 'yas-expand)
	)

(use-package avy
  :defer t
	) ; you can use dC<char> to delete until <char>

(defun read-file-line-by-line (filepath)
  "Print each line of filepath's file content."
  (with-temp-buffer
    (insert-file-contents filepath)
    (while (not (eobp))
      (let ((line (buffer-substring-no-properties
                   (line-beginning-position)
                   (line-end-position))))
        (forward-line 1)))))


;; (use-package openai
;; 	:quelpa (openai :fetcher github :repo "emacs-openai/openai"))

;; (use-package chatgpt
;; 	:after openai
;; 	:quelpa (chatgpt :fetcher github :repo "emacs-openai/chatgpt")
;; 	:config
;; 	)

(use-package good-scroll
  :config
  (setq good-scroll-step 180)
  (good-scroll-mode 1))

;; (my-load-file "deferred.el")

;; Inertial Scrolling - Better than progressive-speed
;; (use-package inertial-scroll
  ;; :quelpa (inertial-scroll :fetcher github :repo "kiwanami/emacs-inertial-scroll")
  ;; :custom
  ;; (inertias-friction 110)
  ;; :bind
  ;; (("<mouse-4>"     . inertias-down-wheel) ;; Replace mwheel-scroll
   ;; ("<mouse-5>"     . inertias-up-wheel  ) ;; Replace mwheel-scroll
   ;; ("<wheel-up>"    . inertias-down-wheel)
   ;; ("<wheel-down>"  . inertias-up-wheel  )))
