;; coffee ---------------------------------------------------
(defun my-coffee-mode-hook ()
  (setq coffee-tab-width 4)
  (setq tab-width coffee-tab-width)
  (highlight-indentation-mode t)
  (highlight-indentation-current-column-mode t))

(add-hook 'coffee-mode-hook 'flymake-coffee-load)
(add-hook 'coffee-mode-hook 'my-coffee-mode-hook)
