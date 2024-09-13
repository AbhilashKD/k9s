#!/bin/bash

# Function to install AWS CLI
install_aws_cli() {
    echo "Installing AWS CLI..."

    if [[ "$1" == "macOS" ]]; then
        brew install awscli
    elif [[ "$1" == "Ubuntu" || "$1" == "Linux" ]]; then
        sudo apt update
        sudo apt install -y awscli
    elif [[ "$1" == "Windows" ]]; then
        echo "For Windows, please download and install AWS CLI manually from: https://aws.amazon.com/cli/"
    fi
}

# Function to install K9s on Ubuntu
install_k9s_ubuntu() {
    echo "Installing K9s on Ubuntu..."

    echo "1> Go to https://github.com/derailed/k9s/releases"
    echo "Downloading the k9s_Linux_x86_64.tar.gz file from the latest release..."
    
    latest_version=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep "tag_name" | cut -d '"' -f 4)
    wget https://github.com/derailed/k9s/releases/download/$latest_version/k9s_Linux_x86_64.tar.gz
    
    echo "Unpacking the tar.gz file..."
    tar -xvf k9s_Linux_x86_64.tar.gz
    
    echo "Moving k9s binary to /usr/local/bin/..."
    sudo mv k9s /usr/local/bin/
    
    echo "Verifying installation..."
    k9s version
}

# Function to install K9s on macOS
install_k9s_mac() {
    echo "Installing K9s on macOS..."
    
    echo "1> Go to https://github.com/derailed/k9s/releases"
    echo "Downloading the k9s_Darwin_x86_64.tar.gz file from the latest release..."
    
    latest_version=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep "tag_name" | cut -d '"' -f 4)
    wget https://github.com/derailed/k9s/releases/download/$latest_version/k9s_Darwin_x86_64.tar.gz
    
    echo "Unpacking the tar.gz file..."
    tar -xvf k9s_Darwin_x86_64.tar.gz
    
    echo "Moving k9s binary to /usr/local/bin/..."
    sudo mv k9s /usr/local/bin/
    
    echo "Verifying installation..."
    k9s version
}

# Function to install K9s on Windows (manual)
install_k9s_windows() {
    echo "Installing K9s on Windows..."
    echo "1> Go to https://github.com/derailed/k9s/releases"
    echo "Download the k9s_Windows_x86_64.zip file of the latest release."
    echo "Unzip the file and move the k9s.exe binary to a location in your PATH."
    echo "Then open Command Prompt or PowerShell and run 'k9s version' to verify the installation."
}

# Function to install K9s on generic Linux
install_k9s_linux() {
    echo "Installing K9s on Linux..."

    echo "1> Go to https://github.com/derailed/k9s/releases"
    echo "Downloading the k9s_Linux_x86_64.tar.gz file from the latest release..."
    
    latest_version=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep "tag_name" | cut -d '"' -f 4)
    wget https://github.com/derailed/k9s/releases/download/$latest_version/k9s_Linux_x86_64.tar.gz
    
    echo "Unpacking the tar.gz file..."
    tar -xvf k9s_Linux_x86_64.tar.gz
    
    echo "Moving k9s binary to /usr/local/bin/..."
    sudo mv k9s /usr/local/bin/
    
    echo "Verifying installation..."
    k9s version
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Detected OS: macOS"
        OS="macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            if [[ "$ID" == "ubuntu" ]]; then
                echo "Detected OS: Ubuntu"
                OS="Ubuntu"
            else
                echo "Detected OS: Linux"
                OS="Linux"
            fi
        else
            echo "Detected OS: Linux"
            OS="Linux"
        fi
    elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" ]]; then
        echo "Detected OS: Windows"
        OS="Windows"
    else
        echo "Unsupported OS detected."
        exit 1
    fi
}

# Main script
echo "Checking your OS..."
detect_os

# Install AWS CLI
install_aws_cli "$OS"

# Install K9s based on OS
if [[ "$OS" == "Ubuntu" ]]; then
    install_k9s_ubuntu
elif [[ "$OS" == "macOS" ]]; then
    install_k9s_mac
elif [[ "$OS" == "Windows" ]]; then
    install_k9s_windows
elif [[ "$OS" == "Linux" ]]; then
    install_k9s_linux
fi

# Show commands to access K9s
if [[ "$OS" == "Windows" ]]; then
    echo -e "\nTo access K9s on Windows, run the K9s executable from the installed location."
else
    echo -e "\nTo access K9s, simply run the following command in the terminal:"
    echo "k9s"
fi
