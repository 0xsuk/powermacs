(setq ismac (eq system-type 'darwin))
(setq islaptop (string= system-name "LAPTOP-KENDR339"))
(setq mac-command-modifier 'meta)
(require 'package) ; loading package called package
;; no need for below after emacs 27
(package-initialize) ; load other packages installed on computer into emacs, this is equivalent to calling require for each of those.
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
; setup use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
	)
(eval-when-compile (require 'use-package)) ; don't know why eval-when-compile
(setq use-package-always-ensure t) ; always install package if not installed

(use-package quelpa
	:config
	(setq quelpa-update-melpa-p nil))
(use-package quelpa-use-package)
(quelpa-use-package-activate-advice) ; advices use-package to disable always-ensure if :quelpa is found

(delete-selection-mode 1) ; for yas: typedef type name
(global-auto-revert-mode t)
(setq
 save-interprogram-paste-before-kill t ; copy system clipboard to killring before kill
 recentf-max-saved-items 1000
 global-auto-revert-non-file-buffers t ; revert dired and other buffers
 ring-bell-function 'ignore
 blink-cursor-mode nil
 large-file-warning-threshold nil; open large file (Pdf) without warning
 split-width-threshold 1 ; always split horizontally ; no need with popper
 create-lockfiles nil ; do not create #lockfile#
 initial-scratch-message nil
 warning-minimum-level :emergency
 inhibit-startup-message t
 ;; Maintainer: My suggestion is to repeatedly multiply gc-cons-threshold by 2 until you stop seeing significant improvements in responsiveness, and in any case not to increase by a factor larger than 100 or somesuch. If even a 100-fold increase doesn't help, there's some deeper problem with the Lisp code which produces so much garbage, or maybe GC is not the reason for slowdown.
 gc-cons-threshold (* 1000 1000 1000) ; should be lowered after initialization?
 ;; gc-cons-threshold 100000000 ; lsp performance https://emacs-lsp.github.io/lsp-mode/page/performance/
 read-process-output-max (* 1024 1024) ; same
 scroll-conservatively 1
 scroll-step 1
 ;; scroll-margin 10 ; take margin at the top and the bottom
 echo-keystrokes 0.01 ; echo area (the most bottom message area delay
 custom-file "~/.emacs.d/custom-file.el" ;append "custom configuration" generated by emacs to there
 auto-save-file-name-transforms
 `((".*" "~/.emacs.d/auto-save-list/autosave/" t))
 backup-directory-alist '(("." . "~/.emacs.d/backup"))
 delete-old-versions t ; delete execess backup versions
 shell-command-prompt-show-cwd t
 async-shell-command-buffer 'new-buffer ; always create new buffer without asking when other command is running
 async-shell-command-display-buffer nil ; do not open buffer if shell command no output
 kill-buffer-query-functions
 (remq 'process-kill-buffer-query-function
			 kill-buffer-query-functions) ; kill live process without asking when buffer is closing
 scroll-preserve-screen-position 'always
 ;; switch-to-buffer-obey-display-actions t ; treats manual buffer switching the same as programatic switching
 switch-to-buffer-in-dedicated-window nil ; disallow switching in the dedicated
 window-sides-slots '(1 1 1 1) ; number of side windows allowed on each side
 eldoc-idle-delay 0.2
 )
(load-file custom-file)
(setq-default
 tab-width 2
 js-indent-level 2
 indent-tabs-mode nil
 sh-indentation 2)
(scroll-bar-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(line-number-mode -1)
(visual-line-mode 1)
(global-eldoc-mode -1)
(recentf-mode)
(fset 'yes-or-no-p 'y-or-n-p)
;(setq debug-on-error nil) ; verbose error
(if islaptop
    (set-face-attribute 'default nil :height 140)
  (set-face-attribute 'default nil :height 150))
(winner-mode 1)
(electric-pair-mode t) ; auto close parentheses
(show-paren-mode -1) ; colorize matching parenthesis under cursor
;; (setq show-paren-delay 0.1)
(global-tab-line-mode 1)
(global-display-line-numbers-mode 0)
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
; no need for this on bash ;; (setq shell-command-switch "-ic") ; allows zsh alias
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(defadvice find-file (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir t)))))

(defmacro k-time (&rest body)
  "Measure and return the time it takes evaluating BODY."
  `(let ((time (current-time)))
     ,@body
     (float-time (time-since time))))

(defvar k-gc-timer
  (run-with-idle-timer 15 t
                       (lambda ()
                         (message "Garbage Collector has run for %.06fsec"
                                  (k-time (garbage-collect))))))
