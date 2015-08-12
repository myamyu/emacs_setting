;;; init.el --- emacsの設定
;;; Commentary:
;;; Code:

;; package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; load-path
(setq load-path
      (append
       (list
        (expand-file-name "~/.emacs.d/elisp"))
       load-path))

;; key
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c o") 'org-capture)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x j") 'open-junk-file)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; OS判定
(defvar *run-unix*
  (or (equal system-type 'gnu/linux)
      (equal system-type 'darwin)
      (equal system-type 'usg-unix-v)))
(defvar *run-win*
  (and (null *run-unix*)
       (or (equal system-type 'windows-nt)
	   (equal system-type 'ms-dos))))

;; 文字コード
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)

;; 日本語入力
(when (require 'skk nil t)
  (setq default-input-method "japanese-skk")
  (require 'skk-study))
(require 'ac-ja)
(setq ac-sources (append ac-sources '(ac-source-dabbrev-ja)))

;; 見た目
(custom-set-variables
 '(column-number-mode t)
 '(display-time-mode t)
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(global-hl-line-mode t)
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

;; フォント
(if *run-win*
    (progn
      (set-face-attribute 'default nil :family "Consolas" :height 130)
      (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo UI"))))

;; インデントなど
(setq-default
 default-tab-width 2
 indent-tabs-mode nil
 c-tab-always-indent t
 c-auto-newline t
 c-hungry-delete-key t)

;; org-mode, junk
(require 'org)
(require 'open-junk-file)
(setq org-directory "~/org-memo/")
(defvar junk-directory (concat org-directory "junk/"))
(setq org-default-notes-file (concat org-directory "memo.org"))
(setq org-agenda-files (list
                        org-directory
                        junk-directory))
(setq open-junk-file-format (concat junk-directory "%Y-%m%d.org"))

;; projectile
(require 'projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

;; js-mode
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(add-hook 'js-mode-hook
          '(lambda ()
             (setq js-indent-level 2)
             (setq js-basic-offset 2)
             (highlight-indentation-mode)
             (highlight-indentation-current-column-mode)
             (auto-complete-mode)))
;; css-mode
(add-hook 'css-mode-hook
          '(lambda ()
             (setq css-indent-offset 2)
             (setq css-tab-mode 'indent)
             (setq indent-tabs-mode t)
             (auto-complete-mode)))

;; server
(add-hook 'server-visit-hook
	  (lambda ()
	    (set-terminal-coding-system 'utf-8)
	    (set-keyboard-coding-system 'utf-8)))
(require 'server)
(unless (server-running-p)
  (server-start))

(provide 'init)
;;; init.el ends here
