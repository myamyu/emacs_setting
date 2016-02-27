;;; my-package-install.el --- インストールするパッケージ
;;; Commentary:
;;; Code:

(defun my:install ()
  "Install my package.
インストールされていないパッケージをインストール。"
  (defvar my:packages
    '(
      ;; org
      org
      ob-http
      ob-kotlin
      ob-typescript
      open-junk-file
      ;; project
      projectile
      projectile-codesearch
      ;; auto complete
      auto-complete
      ac-dabbrev
      ac-helm
      ac-html
      ac-ja
      ac-js2
      ac-skk
      ac-R
      ac-python
      company
      company-web
      tern
      tern-auto-complete
      ;; coding mode
      clojure-mode
      coffee-mode
      haml-mode
      js2-mode
      sass-mode
      scss-mode
      tide
      typescript-mode
      web-mode
      yaml-mode
      python-mode
      elixir-mode
      jade-mode
      qml-mode
      ruby-electric
      ruby-block
      alchemist
      elixir-mix
      ;; flycheck
      flycheck
      flycheck-clojure
      flycheck-elm
      flycheck-pos-tip
      ;; git, github
      gh
      gh-md
      gist
      git-commit
      git-gutter
      gitconfig-mode
      gitignore-mode
      ignoramus
      hyde
      jekyll-modes
      julia-mode
      magit
      magit-popup
      ;; helm
      helm
      helm-R
      helm-ag
      helm-core
      helm-css-scss
      helm-flycheck
      helm-gist
      helm-git
      helm-git-files
      helm-git-grep
      helm-google
      helm-hatena-bookmark
      helm-ls-git
      helm-package
      helm-projectile
      ;; etc
      anzu
      auto-compile
      cider
      dash
      ddskk
      elang
      epl
      google
      markdown-mode
      markdown-mode+
      request
))
  (dolist (package my:packages)
    (when (or (not (package-installed-p package)))
      (package-install package))))

(provide 'my-package-install)
;;; my-package-install.el ends here

