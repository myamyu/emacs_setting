;; js -------------------------------------------------------
(defun my-js2-mode-hook ()
  (setq c-basic-offset 4)
  (setq tab-width c-basic-offset)
  (setq indent-tabs-mode t))

;; jslintはnpm -gでinstallする必要があるかも
(add-hook 'js2-mode-hook 'flymake-jslint-load)
(add-hook 'js2-mode-hook 'my-js2-mode-hook)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

