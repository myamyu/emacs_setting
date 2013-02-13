;; php -----------------------------------------------------
(require 'mmm-mode)
(setq mmm-global-mode 'maybe)
(mmm-add-classes
 '((html-php
    :submode php-mode
    :front "<\\?"
    :back "\\?>")))
(mmm-add-mode-ext-class nil "\\.ctp$" 'html-php)
(add-to-list 'auto-mode-alist '("\\.ctp$" . html-mode))
;; タブの改善
(defun save-mmm-c-locals ()
  (with-temp-buffer
    (php-mode)
    (dolist (v (buffer-local-variables))
      (when (string-match "\\`c-" (symbol-name (car v)))
	(add-to-list 'mmm-save-local-variables `(,(car v) nil, mmm-c-derived-modes))))))
(save-mmm-c-locals)

(require 'php+-mode)
(defun my-php-mode-hook ()
  (setq whitespace-action (quote (auto-cleanup)))
  (setq c-basic-offset 4)
  (setq php-basic-offset 4)
  (setq tab-width c-basic-offset)
  (linum-mode t)
  (auto-complete-mode))

(add-hook 'php+-mode-hook 'flymake-php-load)
(add-hook 'php+-mode-hook 'my-php-mode-hook)
(add-to-list 'auto-mode-alist '("\\.php$" . php+-mode))
