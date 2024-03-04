![CateyeV7.png](CateyeV7.png)

# cateye (Japanese: キャットアイ)

This is software for installing Open-source Software.

[Package repo](https://github.com/Kamu-JP/cateye-packages) | [Introduction page (Japanese)](https://dl.kamu.jp/cateye/) | [Homebrew](https://github.com/DiamondGotCat/homebrew-cateye/) | [Packages by Kamu Dev](https://dl.kamu.jp/cateye/packages/) | [for Windows](https://github.com/Kamu-JP/cateye-win/) | [Terminal Theme](https://github.com/Kamu-JP/cateye/wiki/Catheme-for-macOS-Terminal)

## Versions

- Cateye 1 ~ 5: None
- Cateye 6: "Golden-Drive"
- Cateye 7: "Green-and-Sky"

## Operating environment

### macOS & Linux
**Tested:**
- macOS Sonoma (Apple silicon), Homebrew 4.2.9
- Fedora linux 38 (arm64)

## Download, Install and Setup Cateye with Homebrew

### Install homebrew

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

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

### Ensure that the environment necessary for Cateye to operate is in place

```zsh
sudo cateye doctor
```

## Install or Update Kamu Package from Kamu Dev With Cateye

```zsh
sudo cateye install [package name]
```

## Install or Update Kamu Package from Other Site With Cateye

```zsh
sudo cateye url [url of Kamu Package JSON]
```

## Install or Update Kamu Package from File With Cateye

```zsh
sudo cateye file [path of Kamu Package JSON]
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
  "macos14": "Enter the package URL for the specified OS here. In this case, enter the URL for macOS Sonoma (14.x.x). (This key is optional)",
  "linux38": "Enter the package URL for the specified OS here. In this case, enter the URL for Fedora linux 38. (This key is optional)",
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
Catest is software that checks whether Cateye is working properly.

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
