;;; TODO
; [MAYBE] incorporate meow motion to evil
; C-u C-SPC jump back

;;; TIL
; isearch-forward-word
; key-binding -> returns function in active keymaps
; lookup-key -> returns function
; use c-r to go to the beginning of the search match, use C-w to include next word search
; use-package bind-keymaps* override all minor mode
; key chord.el
; https://emacs.stackexchange.com/questions/352/how-to-override-major-mode-bindings create a ryo-modal minor mode that override EVERY keymap
; $$ to grab output of last command
; copy output of last command

;; tab
;; (setq tab-bar-show nil)
;; (tab-bar-mode)
;; (setq tab-bar-new-button nil)
;; (setq tab-bar-close-button nil)
(defun my-load-file (filename)
	(load (concat user-emacs-directory "lisp/" filename)))
(my-load-file "utils.el")
(my-load-file "basic.el")
(my-load-file "cosmetics.el")
(my-load-file "etc.el")
;; (my-load-file "exwm.el")
;; (my-load-file "evil.el")
(my-load-file "popper.el")
;; (my-load-file "display-buffer.el")
(my-load-file "purpose.el")
(my-load-file "elfeed.el")
		
;; (my-load-file "god.el")
(my-load-file "anime.el")
;; (my-load-file "company.el")
;; (my-load-file "ivy.el")
;; (my-load-file "counsel.el")
(my-load-file "dired.el")
(my-load-file "eshell.el")
(my-load-file "languages.el")
(my-load-file "lsp.el")
;; (my-load-file "eglot.el")
(my-load-file "magit.el")
(my-load-file "vertico.el")
(my-load-file "orderless.el")
(my-load-file "marginalia.el")
(my-load-file "consult.el")
(my-load-file "embark.el")
;; (my-load-file "lsp-bridge.el")
(my-load-file "corfu.el")
(my-load-file "prescient.el")
(my-load-file "meow.el")
;; (my-load-file "ryo.el")
;; (my-load-file "pdf.el")
(my-load-file "org.el")
;; (my-load-file "tabline.el")
(my-load-file "centaur.el")
(my-load-file "vterm.el")
;; (my-load-file "term-keys.el")
;;(my-load-file "kakoune.el")
;; (my-load-file "modalka.el")
;; (my-load-file "hydra.el")
;; (my-load-file "mymode.el")
;; (my-load-file "tmp.el")
(my-load-file "japanese.el")
;; (unless islaptop
;; 	(my-load-file "eaf.el"))
;; (my-load-file "supercollider.el")
(my-load-file "bindings.el")

(defun fix-bindings ()
  (interactive)
  (define-key input-decode-map "\C-i" [C-i]) ; https://emacs.stackexchange.com/questions/17509/how-to-distinguish-c-i-from-tab
  (define-key input-decode-map [?\C-\[] (kbd "<C-[>")) ; https://emacs.stackexchange.com/questions/10271/how-to-bind-c-for-real-seriously-for-real-this-time
  )
(fix-bindings)
(my-window-transparent)
(message "INIT COMPLETE")
