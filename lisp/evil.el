(general-evil-setup)

(use-package evil
	:demand t
	:config
	(setq evil-want-cursor-back nil
				evil-move-beyond-eol t)
	;; (setq evil-insert-state-map (make-sparse-keymap)
				;; evil-normal-state-map (make-sparse-keymap)
				;; evil-motion-state-map (make-sparse-keymap))
	(evil-mode)

	;; (general-def 'insert "<escape>" 'evil-normal-state)
	;; (general-def 'normal
		;; No bind to modifier key
		;; "i" 'evil-insert-state
		;; "I" 'evil-insert
		;; "j" 'next-line
		;; "k" 'previous-line
		;; "l" 'forward-char
		;; "h" 'backward-char
		;; "n" 'my-scroll-down
		;; "p" 'my-scroll-up
		;; "f" 'forward-word
		;; "b" 'backward-word ; beginning of word
		;; "w" 'forward-to-word ; beginning of word
		;; "e" 'backward-to-word
		;; )
	)
