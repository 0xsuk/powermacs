(use-package ivy ;  a generic completion mechanism for Emacs.
	:init
	(ivy-mode 1)
	(general-def ivy-minibuffer-map
		;; "<escape>"  'minibuffer-keyboard-quit
		"TAB"  'ivy-alt-done
		"C-j"  'ivy-next-line
		"C-k"  'ivy-previous-line
		"C-<return>" 'ivy-immediate-done
		"<deleteline>" nil
		)
	(general-def ivy-reverse-i-search-map
		"C-k" 'ivy-previous-line)
	(general-def ivy-switch-buffer-map
		"C-k"  'ivy-previous-line ; default is ivy-switch-buffer-kill, used when counsel-switch-buffer
		"C-d"  'ivy-switch-buffer-kill ; kill a buffer using ivy switch buffer
		)
	;(general-def ivy-minibuffer-map
	;	"C-d" 'my-ivy-k) ; TODO do not want to exit
  (setq ivy-extra-directories nil) ; remove . and .. from find-file
  :config
  )
(use-package ivy-prescient
	:after counsel
	:config
	(ivy-prescient-mode 1)
	(setq ivy-prescient-sort-commands '(:not swiper swiper-isearch ivy-switch-buffer counsel-recentf counsel-ime
nu counsel-esh-history counsel-yank-pop)))
(use-package ivy-rich ; help message for M-x
  :init
  ;(ivy-rich-mode 1)
	)
(use-package ivy-hydra ; rich ivy meny when M-o or C-o
	:after ivy
	:config
	(setq ivy-read-action-function 'ivy-hydra-read-action) ; https://github.com/abo-abo/swiper/issues/2397
	;; (setq ivy-dispatching-done-hydra-exit-keys '(("<escape>" nil "back"))) ; after M-o, escape to go back
	)
