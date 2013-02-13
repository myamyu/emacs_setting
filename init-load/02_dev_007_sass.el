;; scss -----------------------------------------------------
(defun my-scss-mode-hook ()
  (setq scss-indent-level 4)
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (setq scss-compile-at-save nil)
  (auto-complete-mode))

(add-hook 'scss-mode-hook 'flymake-sass-load)
(add-hook 'scss-mode-hook 'my-scss-mode-hook)
