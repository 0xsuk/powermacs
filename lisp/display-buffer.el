(defmacro if-major-mode-function (mode)
	'(lambda (buffer alist)
		 (with-current-buffer buffer
			 (eq major-mode ',mode))))

(defun my-display-function (buffer &optional alist)
	(message "mdf")
	(print alist))

(add-to-list 'display-buffer-alist
						 `(,(if-major-mode-function Man-mode)
							 (my-display-function)))
