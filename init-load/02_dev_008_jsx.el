;; jsx --------------------------
(require 'jsx-mode)
(defun my-jsx-mode-hock ()
  (setq jsx-indent-level 2)
  (setq jsx-use-flymake t))

(add-hook 'jsx-mode-hook 'my-jsx-mode-hock)
(add-to-list 'auto-mode-alist '("\\.jsx$" . jsx-mode))
