(use-package kakoune
	:bind ("C-z" . ryo-modal-mode)
	:hook (after-init . my-kakoune-setup)
	:config
  (defun ryo-enter () "Enter normal mode" (interactive) (ryo-modal-mode 1))
	(defun my-kakoune-setup ()
      "Call kakoune-setup-keybinds and then add some personal config."
      (kakoune-setup-keybinds)
      (setq ryo-modal-cursor-type 'box)
      (add-hook 'prog-mode-hook #'ryo-enter)
      ;; Access all C-x bindings easily
      (define-key ryo-modal-mode-map (kbd "z") ctl-x-map)
      (ryo-modal-keys
       ("," save-buffer)
       ("P" counsel-yank-pop)
       ("m" mc/mark-next-like-this)
       ("M" mc/skip-to-next-like-this)
       ("n" mc/mark-previous-like-this)
       ("N" mc/skip-to-previous-like-this)
       ("M-m" mc/edit-lines)
       ("*" mc/mark-all-like-this)
       ("v" er/expand-region)
       ("C-v" set-rectangular-region-anchor)
       ("M-s" mc/split-region)
			 ("C-j" my-scroll-down :first '(deactivate-mark))
			 ("C-k" my-scroll-up :first '(deactivate-mark))
       ("C-u" scroll-down-command :first '(deactivate-mark))
       ("C-d" scroll-up-command :first '(deactivate-mark))))
	)
