emacsの設定
=============

いろいろ思うところがあり、やりなおします。

やり直す点
------------

目指せ、Bracketsよりも使いやすいEmacs！

### インデントはスペース2こ

以前はタブ派だったのですが、今後は基本的には空白2個。

### helmを有効活用

なんとなくhelmがめっちゃいい感じなので、helm推しにします。

### あまり書かないmodeは入れない

「いつかやる」？・・・いいえ、やりません。

新たにやること
------------

### 新しい環境対応

あたらしいPCとかVMとかで、すぐにいろいろ入れられるように、
入れたパッケージはelisp/my-package-install.elにまとめる。

```
;; *scratch*で実行
(progn
  (require 'my-package-install)
  (my:install))
```

### projectileを導入

Bracketsを使っていて便利なのがprojectの切り替え。
同様の機能であるprojectileを導入します。

### projectile-grepのためにMinGWをインストール

findでは、なんかうまいこと動かないらしいので。
http://www.mingw.org/ ここからダウンロード→インストール。

### ag(Silver Searcher)をダウンロード

projectile-agもつかってみるため。
http://blog.kowalczyk.info/software/the-silver-searcher-for-windows.html ここから。

### curlを使えるようにする

helm-hatena-bookmarkのために、curlが必要らしい。

http://april.fool.jp/blogs/2014/02/windows%E3%81%A7curl%E3%82%92%E4%BD%BF%E3%81%8A%E3%81%86%E3%80%82%E3%81%82%E3%82%8B%E3%81%84%E3%81%AFmicrosoft-security-essential%E3%81%AE%E5%AE%9A%E7%BE%A9%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB/ を参考に
http://curl.haxx.se/download.html から Win64 - MinGW64 のbinayをDLして、MinGWのbinへ配置。

