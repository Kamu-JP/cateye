# cateye
Download and Install `Kamu Package`

## Install Cateye

```zsh
brew tap DiamondGotCat/cateye
brew install cateye
```

## [ Download and Install ] or [ Update ] Kamu Package from Kamu Dev With Cateye

```zsh
sudo cateye install [package name]
```

## [ Download and Install ] or [ Update ] Kamu Package from Other Site With Cateye

```zsh
sudo cateye url [package name] [url of Kamu Package JSON]
```

## Update Cateye

```zsh
sudo cateye update
```

## Catest (Cateye Testing File)

```zsh
sudo cateye install catest
```

### Install Catest Screen (V1.2)

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

### Test

```zsh
catest
```

#### Testing Screen (OK Screen)

```
welcome!
```

#### Testing Screen (NG Screen)

```
zsh: command not found: catest
```
