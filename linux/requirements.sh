#!/bin/bash
source DontEdit.sh
requiredments(){
# Check if the OS is Linux
if [[ "${OSTYPE}" == "${OS}"* ]]; then
    if ping -c 1 google.com >/dev/null 2>&1; then
        # Function to install package using apt package manager
        install_linux_package() {
            package_name="$1"
            sudo apt-get install "${package_name}" -y
            echo -e "[ ${GREEN}OK${NC} ] ${package_name} installed successfully."
        }

        # Function to install package using pip
        install_pip_package() {
            package_name="$1"
            python3 -m pip install --user --upgrade "${package_name}"
            echo -e "[ ${GREEN}OK${NC} ] ${package_name} installed successfully."
        }

        # Function to upgrade pip
        upgrade_pip() {
            python3 -m pip install --upgrade pip
            echo -e "[ ${GREEN}OK${NC} ] pip packages updated successfully."
        }

        # Install APT packages
        for package in "${Packages[@]}"; do
            install_linux_package "${package}"
        done

        echo ""
        echo "_________PIP PACKAGES________"
        # Install PIP packages
        for PIP in "${pipPackages[@]}"; do
            install_pip_package "${PIP}"
        done

        # Update PIP
        echo ""
        echo "_________PIP UPDATES________"
        upgrade_pip

        echo "All packages installed successfully."

    else
        echo -e "[ ${RED}FAIL${NC} ] NOT CONNECTED TO THE INTERNET"
    fi
else
    echo -e "[ ${RED}FAIL${NC} ] Wrong OS, please use the correct OS."
fi
}
requiredments