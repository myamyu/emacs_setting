;; python ---------------------------------------------------
(defun my-python-mode-hook ()
  (setq py-indent-offset 4)
  (highlight-indentation-mode t)
  (highlight-indentation-current-column-mode t))
  
(add-hook 'python-mode-hook 'my-python-mode-hook)
