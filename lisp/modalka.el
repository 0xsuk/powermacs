(use-package modalka
	:config
	(global-set-key (kbd "<escape>") #'modalka-mode)
	(modalka-global-mode 1)

	(modalka-define-kbd "W" "M-w")
	(modalka-define-kbd "Y" "M-y")
	(modalka-define-kbd "a" "C-a")
	(modalka-define-kbd "b" "C-b")
	(modalka-define-kbd "e" "C-e")
	(modalka-define-kbd "f" "C-f")
	(modalka-define-kbd "g" "C-g")
	(modalka-define-kbd "n" "C-n")
	(modalka-define-kbd "p" "C-p")
	(modalka-define-kbd "w" "C-w")
	(modalka-define-kbd "y" "C-y")
	)
