![Cateye-new-color](https://github.com/Kamu-JP/cateye/assets/124330624/a29c27e3-f787-4b6f-8558-9d5e8bdc55b7)

Cateye is a powerful tool designed for installing open-source software effortlessly. Whether you're a developer or a regular user, Cateye simplifies the process of managing and installing software packages on your system. Below, you'll find everything you need to know to get started with Cateye.

## Features and Benefits

- **Streamlined Installation:** Easily install and manage open-source software packages.
- **Cross-Platform Compatibility:** Works seamlessly on macOS and Linux systems.
- **Package Management:** Install or update packages from Kamu Dev or other sources with ease.
- **Developer-Friendly:** Create and publish your own software packages effortlessly.

## Installation

### macOS & Linux

#### Prerequisites
- macOS Sonoma or Linux system
- Homebrew
- Internet connection

#### Installer for macOS (Homebrew is also required)

1. **[Download Installer](https://dl.kamu.jp/cateye/CateyeInstaller.zip)**
4. **Unzip**
5. **Open Installer (Right click and open from menu)**
6. **Click Plus Icon**

#### Homebrew (Also install Homebrew)

1. **Install Homebrew**

    ```zsh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

2. **Tap into Cateye repository**

    ```zsh
    brew tap DiamondGotCat/cateye
    ```

3. **Install Cateye**

    ```zsh
    brew install cateye
    ```

4. **Update to the latest version**

    ```zsh
    sudo cateye update
    ```

5. **Verify installation**

    ```zsh
    sudo cateye doctor
    ```

## Package Management

### Install official or authorised packages

```zsh
sudo cateye install [package name]
```

### Install packages from the web

```zsh
sudo cateye url [url of Kamu Package JSON]
```

### Install local packages

```zsh
sudo cateye file [path of Kamu Package JSON]
```

### Update Cateye

```zsh
sudo cateye update
```

## For Developers

### Creating Kamu Package JSON

To create a Kamu Package JSON, follow this structure and publish it on the web.

```json
{
  "name": "example_json",
  "url": "Specify the URL of the Tar file containing the binary or Unix executable file here",
  "macos14": "Enter the package URL for macOS Sonoma (14.x.x) here. (Optional)",
  "linux38": "Enter the package URL for Fedora linux 38 here. (Optional)",
  "dependencies": [
    "Specify dependency Kamu Package JSON file here",
    "Specify dependency Kamu Package JSON file here (2)"
  ],
  "script": [
    "Commands to set up the package, if needed",
    "Multiple commands executed in order, if applicable"
  ]
}
```

# Catest (Cateye Testing File)

Catest is a complementary tool designed to check the proper functioning of Cateye.

## Installation of Catest

```zsh
sudo cateye install catest
```

## Testing Catest

```zsh
catest
```

### Testing Results

- **OK Screen:**
  ```
  State: OK!
  ```

- **NG Screen:**
  ```
  zsh: command not found: catest
  ```

## Additional Resources

- [Package repository](https://github.com/Kamu-JP/cateye-packages)
- [Introduction page (Japanese)](https://dl.kamu.jp/cateye/)
- [Homebrew repository](https://github.com/DiamondGotCat/homebrew-cateye/)
- [Packages by Kamu Dev](https://dl.kamu.jp/cateye/packages/)
- [Cateye for Windows](https://github.com/Kamu-JP/cateye-win/)
- [Terminal Theme](https://github.com/Kamu-JP/cateye/wiki/Catheme-for-macOS-Terminal)

With Cateye, managing and installing open-source software has never been easier. Start using Cateye today and simplify your software management workflow!
