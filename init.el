
;; win判定
(defvar run-windows
  (or (equal system-type 'windows-nt)
      (equal system-type 'ms-dos)))

;; ---------------------------------------------------------
;; 文字コードまわり
;; ---------------------------------------------------------
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'cp932)
(setq file-name-coding-system 'cp932)
(setq locale-coding-system 'cp932-dos)

;; ---------------------------------------------------------
;; 行列表示
;; ---------------------------------------------------------
(line-number-mode t)
(column-number-mode t)

;; ---------------------------------------------------------
;; パッケージ設定
;; ---------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
;; auto-installのパッケージ
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
;;(auto-install-update-emacswiki-package-name t)


;; svn ------------------------------------------------------
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)

;; magit ----------------------------------------------------
(if run-windows
	(setq magit-git-executable "C:/Program Files/Git/bin/git.exe"))

;; auto complete --------------------------------------------
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)

;; html -----------------------------------------------------
(defun my-html-mode-hook ()
  (setq sgml-basic-offset 4)
  (setq tab-width sgml-basic-offset)
  (setq indent-tabs-mode t))

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


;; python ---------------------------------------------------
(defun my-python-mode-hook ()
  (setq py-indent-offset 4)
  (highlight-indentation-mode t)
  (highlight-indentation-current-column-mode t))
  
(add-hook 'python-mode-hook 'my-python-mode-hook)
			 
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
  (setq scss-compile-at-save nil))

(add-hook 'scss-mode-hook 'flymake-sass-load)
(add-hook 'scss-mode-hook 'my-scss-mode-hook)


;; ---------------------------------------------------------
;; server
;; ---------------------------------------------------------
(server-start)

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
 '(default ((t (:family "ＭＳ ゴシック" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
