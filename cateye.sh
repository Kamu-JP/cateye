#!/bin/bash

cateyeversion="7.0.1"
cateyechanges="Update download process"

# Extract command and package name from argument
command="$1"

# Check if running with sudo
if [ $EUID -ne 0 ]; then
    echo "Must be run as root" 
    exit 1
fi

download_and_install() {
    local url="$1"
    local filename
    filename=$(basename "$url")
    curl -s -LO "$url" || { logging "error" "Failed to download: $url" ; exit 1; }
    tar -xzf "$filename" || { logging "error" "Failed to extract $filename" ; rm "$filename"; exit 1; }
    rm "$filename"
    # Assuming the extracted folder contains binaries to add to system bin directory
    sudo cp -r "./$package_name" "/usr/local/bin/" || { logging "error" "Failed to install $filename" ; rm "./$package_name"; exit 1; }
    rm "./$package_name"
    chmod +x "/usr/local/bin/$package_name"
}

logging() {

    local mode="$1"
    local message="$2"
    local color="$3"
    local color_code
    case $color in
        "red")
            color_code="31m"
            ;;
        "green")
            color_code="32m"
            ;;
        "orange")
            color_code="33m"
            ;;
        "yellow")
            color_code="33m"
            ;;
        "cyan")
            color_code="36m"
            ;;
        "blue")
            color_code="34m"
            ;;
        "purple")
            color_code="35m"
            ;;
        *)

            color_code="0m"

            case $mode in
                "step")
                    color_code="34m"
                    ;;
                "info")
                    color_code="32m"
                    ;;
                "warn")
                    color_code="33m"
                    ;;
                "error")
                    color_code="31m"
                    ;;
                "checkmark")
                    color_code="32m"
                    ;;
                "xmark")
                    color_code="31m"
                    ;;
            esac

            ;;
    esac
    case $mode in
        "step")
            printf "\e[$color_code>\e[0m $message\n"
            ;;
        "info")
            printf "\e[$color_code[+]\e[0m $message\n"
            ;;
        "warn")
            printf "\e[$color_code[-]\e[0m $message\n"
            ;;
        "error")
            printf "\e[$color_code\xE2\x9C\x98\e[0m $message\n"
            ;;
        "checkmark")
            printf "\e[$color_code\xE2\x9C\x94\e[0m $message\n"
            ;;
        "xmark")
            printf "\e[$color_code\xE2\x9C\x98\e[0m $message\n"
            ;;
        *)
            printf "\e[$color_code[!]\e[0m Internal script error, unknown mode: $mode\n"
            exit 1
            ;;
    esac
}

loadbar() {
    local pid=$!
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf "\e[32m [%c]  \e[0m" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

draw_progress_bar() {

    # 完了した場所の割合 (0.0 - 1.0)
    progress=$1

    # 実行している処理
    task=$2

    # プログレスバーの幅
    BAR_WIDTH=50

    local width=50
    local progress=$1

    # プログレスバーの幅を計算
    local completed_width=$(printf "%.0f" $(echo "$progress * $width" | bc))

    # プログレスバーの表示
    printf "\r("

    # 完了した部分を青で表示
    for ((i = 0; i < completed_width; i++)); do
        printf "\033[44m \033[m"
    done

    # 未完了の部分をマゼンタで表示
    for ((i = completed_width; i < width; i++)); do
        printf "\033[45m \033[m"
    done

    printf ")"

    # パーセントの表示
    percent=$(printf "%.0f" $(echo "$progress * 100" | bc))
    printf " %3d%%" $percent

    printf " | $task"

    printf " "

}

install_dependencies() {

    local package_url
    local json_url
    local pkg_json
    local package_name
    local dependencies
    local os_id
    local target_key
    local result
    local url_of_software_for_this_os
    local main_url
    local runscript
    local scripts
    local script
    
    package_url="$1"
    json_url="$package_url"
    pkg_json=$(curl -sS "$json_url") || { logging "error" "Failed to retrieve JSON File from $json_url" ; exit 1; }
    package_name=$(echo "$pkg_json" | jq -r '.name')
    dependencies=$(echo "$pkg_json" | jq -r '.dependencies | to_entries[] | .value')
    for url in $dependencies; do
        install_dependencies "$url"
    done
    os_id=$(get_os)
    target_key="$os_id"
    result=$(echo "$pkg_json" | jq ". | has(\"$target_key\")")
    if [ "$result" == "true" ]; then
        download_and_install "$url_of_software_for_this_os"
    else
        main_url=$(echo "$pkg_json" | jq -r '.url')
        download_and_install "$main_url"
    fi
    runscript=true
    allow_running_script=true
    scripts=$(echo "$pkg_json" | jq -r '.script | to_entries[] | .value') || { logging "warn" "Skip this because there is no setup script."; runscript=false; }
    case $runscript in
        true)

            for script in $scripts; do
                eval "$script"
            done

            ;;
        *)
            ;;
    esac

}

get_os() {
    local os_type="other"
    if [[ "$(uname)" == "Darwin" ]]; then
        os_type="macos"
    elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
        os_type="linux"
    fi

    local os_version="unknown"
    if [[ "$os_type" == "macos" ]]; then
        os_version=$(sw_vers -productVersion)
        os_version=$(echo "$os_version" | awk -F. '{print $1}')
    elif [[ "$os_type" == "linux" ]]; then
        if [ -e /etc/os-release ]; then
            os_version=$(grep "VERSION_ID" /etc/os-release | cut -d '"' -f 2)
            os_version=$(echo "$os_version" | sed 's/VERSION_ID=//')
            os_version=$(echo "$os_version" | awk -F. '{print $1}')
        else
            os_version="unknown"
        fi
    fi

    echo "$os_type$os_version"
}

get_latest_version() {
    local latest_version
    latest_version=$(curl -sS https://github.com/Kamu-JP/cateye/raw/main/version.html)
    echo "$latest_version"
}

install_software() {

    local os_id
    local package_name
    local json_url
    local pkg_json

    if [ -n "$1" ]; then
        if [ -n "$2" ]; then
            logging "checkmark" "The number of arguments is normal. Start the installation."
        else
            logging "error" "Not enough arguments" 
            exit 1
        fi
    else
        logging "error" "Not enough arguments" 
        exit 1
    fi

    case $2 in

        "github")
            
            os_id=$(get_os)
            package_name="$1"
            logging "step" "Start the installation." 
            draw_progress_bar 0 "Download JSON File"
            json_url="https://raw.githubusercontent.com/Kamu-JP/cateye-packages/main/$package_name.json"
            pkg_json=$(curl -sS "$json_url") || { logging "error" "Failed to retrieve JSON File from $json_url"; exit 1; }
            draw_progress_bar 1 "Download JSON File"

            ;;

        "kamujp")
            
            os_id=$(get_os)
            package_name="$1"
            logging "step" "Start the installation." 
            draw_progress_bar 0 "Download JSON File"
            json_url="https://dl.kamu.jp/$package_name/pkg.json"
            pkg_json=$(curl -sS "$json_url") || { logging "error" "Failed to retrieve JSON File from $json_url"; exit 1; }
            draw_progress_bar 1 "Download JSON File"

            ;;

        "file")

            file_path="$1"
            pkg_json=$(cat "$file_path")
            package_name=$(echo "$pkg_json" | jq -r '.name')

            ;;
        "other")
        
            os_id=$(get_os)
            logging "step" "Start the installation." 
            draw_progress_bar 0 "Download JSON File"
            json_url="$1"
            pkg_json=$(curl -sS "$json_url") || { logging "error" "Failed to retrieve JSON File from $json_url"; exit 1; }
            draw_progress_bar 1 "Download JSON File"
            package_name=$(echo "$pkg_json" | jq -r '.name')

            ;;
    esac

    printf "\n"
    dependencies=$(echo "$pkg_json" | jq -r '.dependencies | to_entries[] | .value')
    index_ins_dep=0

    for url in $dependencies; do
        index_ins_dep+=1
        draw_progress_bar 0 "Install dependencies: $url"
        install_dependencies "$url"
        draw_progress_bar 1 "Install dependencies: $url"
        printf "\n"
    done
    os_id=$(get_os)
    target_key="$os_id"
    result=$(echo "$pkg_json" | jq ". | has(\"$target_key\")")
    draw_progress_bar 0 "Install Main software"
    if [ "$result" == "true" ]; then
        download_and_install "$url_of_software_for_this_os"
    else
        main_url=$(echo "$pkg_json" | jq -r '.url')
        download_and_install "$main_url"
    fi
    draw_progress_bar 1 "Install Main software"
    printf "\n"
    draw_progress_bar 0 "Running setup script"
    runscript=true
    allow_running_script=true
    scripts=$(echo "$pkg_json" | jq -r '.script | to_entries[] | .value') || { logging "warn" "Skip this because there is no setup script."; runscript=false; }
    case $runscript in
        true)
            runscript=true
            for script in $scripts; do
                eval "$script"
            done
            ;;
        *)
            logging "step" "Skip Running Install script." 
            ;;
    esac
    draw_progress_bar 1 "Running setup script"
    printf "\n"

    logging "checkmark" "Done." 

    latest_version=$(get_latest_version)
    if [[ "$cateyeversion" != "$latest_version" ]]; then
        logging "warn" "A newer version is available: V$latest_version" 
        logging "warn" "Consider running: cateye update" 
    fi

    if [ "$allow_running_script" == "false" ]; then
        logging "warn" "Skiped setup script, because you answered 'n'. if you want to run the setup script, run the following command." 
        logging "warn" "cateye install $package_name" 
    fi
    
}

case "$command" in
    "update")

        latest_version=$(get_latest_version)
        if [[ "$cateyeversion" == "$latest_version" ]]; then
            logging "step" "cateye V$cateyeversion"
            logging "checkmark" "No update."
        else
            logging "step" "Update cateye V$cateyeversion to V$latest_version"
            logging "info" "Updating Cateye: $current_script"
            current_script="$0"
            logging "info" "Downloading latest script to $current_script"
            curl -sS -o "$current_script" "https://github.com/Kamu-JP/cateye/raw/main/cateye.sh" || { logging "error" "Failed to download latest script"; exit 1; }
            chmod +x "$current_script"
            logging "checkmark" "Updated successfully."
        fi
        ;;
    "version")
        latest_version=$(get_latest_version)
        os_id=$(get_os)
        if [[ "$cateyeversion" == "$latest_version" ]]; then
            logging "step" "cateye V$cateyeversion"
            logging "checkmark" "No update."
        else
            logging "step" "cateye V$cateyeversion"
            logging "warn" "A newer version is available: V$latest_version"
            logging "warn" "Consider running: cateye update" 
        fi
        logging "step" "OS" 
        echo "OS: $os_id"
        logging "step" "PATH of Cateye" 
        echo "PATH: $0"
        logging "step" "Update of current version" 
        logging "info" "$cateyechanges"
        ;;

    "install")

        install_software "$2" "github"

        ;;

    "kamujp")

        install_software "$2" "kamujp"

        ;;

    "file")

        install_software "$2" "file"

        ;;

    "url")

        install_software "$2" "other"

        ;;

    "doctor")

        logging "step" "Show result of doctor" 
        latest_version=$(get_latest_version)
        warnings=0
        errors=0

        if [[ "$cateyeversion" == "$latest_version" ]]; then
            printf "\e[32m[\xE2\x9C\x94]\e[0m cateye V$cateyeversion\n"
        else
            logging "warn" "cateye V$cateyeversion"
            printf "    \e[33m[-]\e[0m A newer version is available: V$latest_version\n"
            printf "    \e[33m[-]\e[0m Consider running: cateye update\n"
            warnings=$((warnings + 1))
        fi

        if command -v jq &> /dev/null; then
            printf "\e[32m[\xE2\x9C\x94]\e[0m jq\n"
        else
            printf "\e[31m[\xE2\x9C\x98]\e[0m jq\n"
            printf "    \e[31m[\xE2\x9C\x98]\e[0m jq is not installed.\n"
            errors=$((errors + 1))
        fi
        
        logging "checkmark" "Finished: $errors errors, $warnings warnings"

        ;;

    *)

        latest_version=$(get_latest_version)
        if [[ "$cateyeversion" == "$latest_version" ]]; then
            logging "step" "cateye V$cateyeversion"
            logging "checkmark" "Up to date."
        else
            logging "step" "cateye V$cateyeversion"
            logging "warn" "A newer version is available: V$latest_version"
            logging "warn" "Consider running: cateye update" 
        fi

        echo " "
        logging "step" "Usage" 
        echo "Update:"
        echo " sudo cateye update"
        echo "Run doctor:"
        echo " sudo cateye doctor"
        echo "Install from Kamu Dev:"
        echo " sudo cateye install [package name]"
        echo "Install from Other Site:"
        echo " sudo cateye url [url of Kamu Package JSON]"
        echo "Show version:"
        echo " sudo cateye version"

        echo "For more information, see https://github.com/Kamu-JP/cateye"

        ;;
esac
