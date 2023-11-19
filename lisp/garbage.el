;(defun my-ivy-k ()
;	(interactive)
;	(require 'hydra)
;	(hydra-default-pre)
;	(hydra-keyboard-quit)
;	(setq hydra-curr-body-fn 'ivy-read-action/body)
;	(hydra--call-interactively-remap-maybe
;	 #'(lambda nil
;			 (interactive)
;			 (progn
;				 (let
;						 ((prev-idx
;							 (car
;								(ivy-state-action ivy-last))))
;					 (setcar
;						(ivy-state-action ivy-last)
;						11)
;					 (ivy-call) ; ivy-call instead of ivy-done
;					 ; press C-k to revert
;					 )))))


;; (dolist (mode '(eshell-mode-hook help-mode-hook treemacs-mode-hook vterm-mode-hook pdf-view-mode-hook dired-mode-hook))
;;   (add-hook mode (lambda () (display-line-numbers-mode 0)))) ;disable line numbers for these buffers

;; (use-package caps-lock)

; EAF
;(use-package eaf
;	:load-path "~/.emacs.d/site-lisp/emacs-application-framework" ; load-path prevents eaf being pulled from melpa
;	:config
;	(require 'eaf-pdf-viewer)
;	)

; Prog mode map
;; (general-def 'normal prog-mode-map
;; 	"J" #'evil-forward-section-begin
;; 	"K" #'beginning-of-defun-raw
;; 	)

;; (use-package tao-theme
;; 	:config
;; 	(setq tao-theme-use-sepia nil)
;; 	(load-theme 'tao-yin)
;; 	)
