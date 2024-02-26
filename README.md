https://github.com/DiamondGotCat/cateye/assets/124330624/08951053-18de-43dc-8c58-fc425ab5f503

Audio by Youtube Audio library

# cateye

Download and Install `Kamu Package`

[Homebrew](https://github.com/DiamondGotCat/homebrew-cateye/) | [Packages by Kamu Dev](https://dl.kamu.jp/cateye/packages/)

## Operating environment

### macOS
**Tested:**
- macOS Sonoma, Homebrew 4.2.9

### Linux
**Not tested**

## Check the [local version] and [latest version] of Cateye

```zsh
sudo cateye version
```

## Download, Install and Setup Cateye with Homebrew

### download info to homebrew

```zsh
brew tap DiamondGotCat/cateye
```

### install cateye with homebrew

```zsh
brew install cateye
```

### Switch to the latest secure version

```zsh
sudo cateye update
```

## Install or Update Kamu Package from Kamu Dev With Cateye

```zsh
sudo cateye install [package name]
```

## Install or Update Kamu Package from Other Site With Cateye

```zsh
sudo cateye url [package name] [url of Kamu Package JSON]
```

## Update (or Reinstall) Cateye

```zsh
sudo cateye update
```

## for Developer

### How to Create [ Kamu Package JSON ]
Create a JSON file with the following structure and publish it on the web.

```json
{

  "name": "example_json",
  "url": "Specify the URL of the Tar file containing the binary or Unix executable file here",
  "dependencies": [

    "Specify dependency Kamu Package JSON file here",
    "Specify dependency Kamu Package JSON file here (2)"

  ],
  "script": [

    "If you need to run a command to set it up, enter it here",
    "If there is more than one, they will be executed in order"

  ]

}
```

# Catest (Cateye Testing File)

```zsh
sudo cateye install catest
```

## Install Catest Screen (V1.2)

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

## Test

```zsh
catest
```

### Testing Screen (OK Screen)

```
State: OK!
```

### Testing Screen (NG Screen)

```
zsh: command not found: catest
```
