https://github.com/DiamondGotCat/cateye/assets/124330624/08951053-18de-43dc-8c58-fc425ab5f503

Audio by Youtube Audio library

# キャットアイ
`Kamu Package`をダウンロードしてインストールするソフトです。

## 動作環境

### macOS
**テスト済み:**
- macOS Sonoma, Homebrew 4.2.9

### Linux
**テストされていません**

## Homebrewでキャットアイをインストール

### 情報をHomebrewへダウンロード

```zsh
brew tap DiamondGotCat/cateye
```

### Homebrewでキャットアイをインストール

```zsh
brew install cateye
```

### 安全なバージョンに切り替える (推奨)

```zsh
sudo cateye update
```

## Kamu-JP公式サイトから`Kamu Package`をインストールまたはアップデートする

```zsh
sudo cateye install [package name]
```

## Kamu-JP公式サイト以外から`Kamu Package`をインストールまたはアップデートする

```zsh
sudo cateye url [package name] [url of Kamu Package JSON]
```

## キャットアイをアップデートまたは再インストール

```zsh
sudo cateye update
```

## キャッテストでキャットアイのテストをする

```zsh
sudo cateye install catest
```

### キャッテストをインストールするときの画面 (バージョン1.2の場合)

```
password: <user's password>
Download and Install Start =>
Download and Install: https://dl.kamu.jp/catest/catest.tar
[-] install
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1063  100  1063    0     0  29502      0 --:--:-- --:--:-- --:--:-- 30371
[+] installed: catest
[+] Installation of catest and that dependencies completed successfully
```

### キャッテストを使う

```zsh
catest
```

#### テストの結果 (正常)

```
welcome!
```

#### テストの結果 (バグが発生している)

```
zsh: command not found: catest
```

## 開発者向け

### [ Kamu Package JSON ] を作る方法
以下の構造のファイルをWeb上に公開すると、キャットアイとそのURLを使用して、あなたの製品をユーザーが簡単にインストールできるようになります。

```json
{

  "url": "Specify the URL of the Tar file containing the binary or Unix executable file here",
  "dependencies": [

    "Specify dependency tar file here",
    "Specify dependency tar file here (2)"

  ],
  "script": [

    "If you need to run a command to set it up, enter it here",
    "If there is more than one, they will be executed in order"

  ]

}
```
