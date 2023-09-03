#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
BRIGHT='\033[1m'
NC='\033[0m' # No Color


start() {

    if [ "$(id -u)" -eq 0 ]; then
        title="ERROR"
        ERROR_MESSAGE="Don't use sudo for this script. Because it can damage your computer"
        osascript -e "display notification \"$ERROR_MESSAGE\" with title \"$title\""

        figlet "ERROR"
        echo "Don't use sudo for this script." 
        echo "Because it can damage your computer"
        exit 1
    else
        if [[ "$1" = "--help" || "$1" = "-h" ]]; then
            echo "This script will install the packages for it to work properly"
        else
            # Check if the OS is macOS
            if [[ "$OSTYPE" == "darwin"* ]]; then 
                if ping -c 1 google.com >/dev/null 2>&1; then
                    # Packages to install
                    Packages=(
                    "fcrackzip"
                    )
                    
                    # Install package
                    install_Brew_package() {
                        package_name="$1"
                        if ! command -v "${package_name}" >/dev/null 2>&1; then
                            echo "${package_name} is not installed. Installing..."
                            # Replace the following command with the appropriate package manager for your Linux distribution
                            brew install "${package_name}"
                        else
                            echo -e "${package_name} is already ${GREEN}installed.${NC}"
                        fi
                    }

                    
                    echo "_________BREW PACKAGES________"

                    # Install BREW packages
                    for package in "${Packages[@]}"; do
                        install_Brew_package "${package}"
                    done
                    
                
                    echo
                    SOUND_FILE="NotifcationSound.mp3"
                    title="Packages"
                    ERROR_MESSAGE="All packages are installed successfully"
                    osascript -e "display notification \"$ERROR_MESSAGE\" with title \"$title\""
                    echo -e "${GREEN}All packages installed.${NC}" # Add this line to indicate successful installation
                    afplay "${SOUND_FILE}";

                else
                    title="ERROR"
                    ERROR_MESSAGE="NOT CONNECTED TO THE INTERNET"
                    osascript -e "display notification \"$ERROR_MESSAGE\" with title \"$title\""
                    echo -e "${RED}ERROR:${NC} NOT CONNECTED TO THE INTERNET"
                fi

            
            
            # Check if the OS is Linux
            else

                RED='\033[0;31m'
                GREEN='\033[0;32m'
                BRIGHT='\033[1m'
                NC='\033[0m' # No Color

                if [ "$(id -u)" -eq 0 ]; then
                    title="ERROR"
                    ERROR_MESSAGE="Don't use sudo for this script. Because it can damage your computer"
                    notify-send "$title" "$ERROR_MESSAGE"
                    
                    echo -e "${RED}ERROR:${NC} Don't use sudo for this script."
                    echo "Because it can damage your computer"
                    exit 1
                else
                    if [[ "$1" = "--help" || "$1" = "-h" ]]; then
                        echo "This script will install the packages for it to work properly"
                    else
                        if ping -c 1 google.com >/dev/null 2>&1; then
                            # Packages to install
                            Packages=(
                                "fcrackzip"
                            )

                            # Install package
                            install_package() {
                                package_name="$1"
                                if ! dpkg -l | grep -q "${package_name}"; then
                                    echo "${package_name} is not installed. Installing..."
                                    sudo apt-get install -y "${package_name}"
                                else
                                    echo -e "${package_name} is already ${GREEN}installed.${NC}"
                                fi
                            }

                            echo "_________APT PACKAGES________"

                            # Install APT packages
                            for package in "${Packages[@]}"; do
                                install_package "${package}"
                            done

                            echo
                            title="Packages"
                            ERROR_MESSAGE="All packages are installed successfully"
                            notify-send "$title" "$ERROR_MESSAGE"
                            echo -e "${GREEN}All packages installed.${NC}" # Add this line to indicate successful installation
                        else
                            title="ERROR"
                            ERROR_MESSAGE="NOT CONNECTED TO THE INTERNET"
                            notify-send "$title" "$ERROR_MESSAGE"
                            echo -e "${RED}ERROR:${NC} NOT CONNECTED TO THE INTERNET"
                        fi
                    fi
                fi
            fi
        fi
    fi
}
start