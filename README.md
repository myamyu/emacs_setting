emacsの設定
=============

New PCにしたときのための対応
------------------------

caskを採用しました。

### caskのインストール

あらかじめ入れておくもの。

- python
- curl(Windowsならchocoで入れるといいかも) https://chocolatey.org/packages/curl

インストールは公式にあるとおりでWindowsも大丈夫。  
http://cask.readthedocs.org/en/latest/guide/installation.html  
※ HOMEの下の.cask/にインストールされるので、そのbinをPATHにいれること。

```
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
```

projectileを導入
----------------

Bracketsを使っていて便利なのがprojectの切り替え。  
同様の機能であるprojectileを導入します。

### projectile-grepのためにMinGWをインストール

findでは、なんかうまいこと動かないらしいので。  
http://www.mingw.org/ ここからダウンロード→インストール。

### ag(Silver Searcher)をダウンロード

projectile-agもつかってみるため。  
http://blog.kowalczyk.info/software/the-silver-searcher-for-windows.html ここから。

