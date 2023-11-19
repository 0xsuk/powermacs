(use-package ryo-modal
  :commands ryo-modal-mode
  :init
  (general-def 'global
    "<escape>" 'ryo-modal-mode)
  :config
  (defun my-dispatch-original ()
    (interactive)
    (ryo-modal-mode -1)
    (let ((f (key-binding "j")))
      (call-interactively f)
      (ryo-modal-mode 1)))
  
  (ryo-modal-keys
   ("j" next-line)
   ("J" my-scroll-down)
   ("k" previous-line)
   ("K" my-scroll-up)
   ("h" backward-char)
   ("l" forward-char)
   ("w" forward-to-word)
   ("e" forward-word)
   ("b" backward-word)
   ("B" backward-to-word)
   ("i" ryo-modal-mode)
   ("v" set-mark-command)
   ("d" (("w" er/mark-word :name "Word" :then (kill-region))
         ("f" er/mark-defun :name "Defun" :then (kill-region))
         ("s" er/mark-outside-quotes :name "Sentence" :then (kill-region))
         ("@" er/mark-symbol :name "Symbol" :then (kill-region))))
   ("SPC j" my-dispatch-original))
  )
  
  )
