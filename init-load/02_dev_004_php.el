;; php -----------------------------------------------------
(require 'mmm-mode)
(defun my-php-mode-hook ()
  (setq c-basic-offset 4)
  (setq sgml-basic-offset 4)
  (setq tab-width c-basic-offset))

(add-hook 'php+-mode-hook 'flymake-php-load)
(add-hook 'php+-mode-hook 'my-php-mode-hook)
(add-to-list 'auto-mode-alist '("\\.php$" . php+-mode))

(setq mmm-global-mode 'maybe)
(mmm-add-classes
 '((html-php
    :submode php+-mode
    :front "<\\?php"
    :back "\\?>")))
(mmm-add-mode-ext-class nil "\\.ctp$" 'html-php)
(add-to-list 'auto-mode-alist '("\\.ctp$" . html-mode))
