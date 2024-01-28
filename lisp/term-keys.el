;; (require 'term-keys-st)
;; (with-temp-buffer
;;   (insert (term-keys/st-config-key))
;;   (write-region (point-min) (point-max) "~/code/st/config-term-keys-key.h"))
;; (with-temp-buffer
;;   (insert (term-keys/st-config-mappedkeys))
;;   (write-region (point-min) (point-max) "~/code/st/config-term-keys-mappedkeys.h"))


; execute above and rebuild st first

(defun my-want-key-p (key mods)
  t)

(use-package term-keys
  :quelpa (term-keys :fetcher github :repo "CyberShadow/term-keys")
  :config
  (term-keys-mode t)
  (setq term-keys/want-key-p-func 'my-want-key-p)
  )
