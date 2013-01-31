;; html -----------------------------------------------------
(defun my-html-mode-hook ()
  (setq sgml-basic-offset 4)
  (setq tab-width sgml-basic-offset)
  (setq indent-tabs-mode t))

(add-hook 'html-mode-hook 'my-html-mode-hook)

