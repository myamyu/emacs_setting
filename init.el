;; win判定
(defvar run-windows
  (or (equal system-type 'windows-nt)
      (equal system-type 'ms-dos)))

;; ---------------------------------------------------------
;; load-path
;; ---------------------------------------------------------
(setq load-path (append (list
			 (expand-file-name "~/.emacs.d/elisp")
			 )
			load-path))

;; ---------------------------------------------------------
;; 文字コード
;; ---------------------------------------------------------
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
;(setq default-file-name-coding-system 'cp932)
;(setq file-name-coding-system 'cp932)
;(setq locale-coding-system 'cp932-dos)

;; ---------------------------------------------------------
;; デフォルト設定
;; ---------------------------------------------------------
;; スペース4つ！
(setq-default tab-width 4 indent-tabs-mode nil)

;; ---------------------------------------------------------
;; パッケージ設定
;; ---------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(setq load-path (append (list
			 (expand-file-name "~/.emacs.d/auto-install")
			 )
			load-path))
;;(auto-install-update-emacswiki-package-name t)

;; ---------------------------------------------------------
;; モードごと設定
;; ---------------------------------------------------------
;; auto complete --------------------------------------------
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)

;; html -----------------------------------------------------
(defun my-html-mode-hook ()
  (setq sgml-basic-offset 4)
  (setq tab-width sgml-basic-offset)
  (setq indent-tabs-mode nil)
  (linum-mode t)
  (auto-complete-mode))
(add-hook 'html-mode-hook 'my-html-mode-hook)
;; js -------------------------------------------------------
(defun my-js2-mode-hook ()
  (setq c-basic-offset 4)
  (setq tab-width c-basic-offset)
  (setq indent-tabs-mode t))
;; jslintはnpm -gでinstallする必要があるかも
(add-hook 'js2-mode-hook 'flymake-jslint-load)
(add-hook 'js2-mode-hook 'my-js2-mode-hook)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; python ---------------------------------------------------
(defun my-python-mode-hook ()
  (setq py-indent-offset 4)
  (highlight-indentation-mode t)
  (highlight-indentation-current-column-mode t))
  
(add-hook 'python-mode-hook 'my-python-mode-hook)
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
(defun my-php-mode-hook ()
  (setq whitespace-action (quote (auto-cleanup)))
  (setq c-basic-offset 4)
  (setq php-basic-offset 4)
  (setq tab-width c-basic-offset)
  (linum-mode t)
  (auto-complete-mode))
(add-hook 'php-mode-hook 'flymake-php-load)
(add-hook 'php-mode-hook 'my-php-mode-hook)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
;; coffee ---------------------------------------------------
(defun my-coffee-mode-hook ()
  (setq coffee-tab-width 4)
  (setq tab-width coffee-tab-width)
  (highlight-indentation-mode t)
  (highlight-indentation-current-column-mode t))
(add-hook 'coffee-mode-hook 'flymake-coffee-load)
(add-hook 'coffee-mode-hook 'my-coffee-mode-hook)
;; scss -----------------------------------------------------
(defun my-scss-mode-hook ()
  (setq scss-indent-level 4)
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (setq scss-compile-at-save nil)
  (auto-complete-mode))
(add-hook 'scss-mode-hook 'flymake-sass-load)
(add-hook 'scss-mode-hook 'my-scss-mode-hook)
;; jsx ------------------------------------------------------
(require 'jsx-mode)
(defun my-jsx-mode-hock ()
  (setq jsx-indent-level 2)
  (setq jsx-use-flymake t))
(add-hook 'jsx-mode-hook 'my-jsx-mode-hock)
(add-to-list 'auto-mode-alist '("\\.jsx$" . jsx-mode))

;; ---------------------------------------------------------
;; server
;; ---------------------------------------------------------
(add-hook 'server-visit-hook
	  (lambda ()
	    (set-terminal-coding-system 'utf-8)
	    (set-keyboard-coding-system 'utf-8)
	    ))
(require 'server)
(unless (server-running-p) (server-start))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu" :foundry "unknown" :slant normal :weight normal :height 120 :width normal)))))
