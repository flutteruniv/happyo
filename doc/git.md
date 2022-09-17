# Git管理対象物について
Git管理対象から外すべきかどうかについて迷ったものをここに列挙していく

### ios/Pods

*** 管理対象とする ***

Podsディレクトリはプロジェクト毎にGit管理とするか否かを決めてよい  
公式推奨はGit管理対象とする  
利点としてはリポジトリのクローンを作成した際に、CocoaPodsがインストールされていなくても、ビルドすることが可能となる。  

参考資料  
https://guides.cocoapods.org/using/using-cocoapods.html

### ios/Podfile ios/Podfile.lock

*** 管理対象とする（仮） ***

一般的なXcodeプロジェクトの場合はGit管理対象とするが、FlutterプロジェクトではFlutterが`Pod install`を実行しているため、もしかしたら管理対象から外した方がいいのかも。  

特にPodfile.lockに関してはビルドの度に絶対パスが出力されるため、毎回コンフリクトが発生するので、管理対象外としてもよいかもしれない

参考資料
https://stackoverflow.com/questions/58397860/should-we-add-podfile-lock-to-gitignore-in-flutter-projects
