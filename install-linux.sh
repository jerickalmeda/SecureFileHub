#!/bin/bash

# SecureFileHub v1.1 - Linux Installation Script
# Supports Ubuntu, Debian, CentOS, RHEL, Fedora, Amazon Linux

set -e

echo "🗂️  SecureFileHub v1.1 - Linux Installation Script"
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Detect Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    DISTRO=$ID
    VERSION=$VERSION_ID
else
    echo -e "${RED}Cannot detect Linux distribution${NC}"
    exit 1
fi

echo -e "${BLUE}Detected OS: $OS${NC}"
echo -e "${BLUE}Distribution: $DISTRO${NC}"
echo -e "${BLUE}Version: $VERSION${NC}"
echo ""

# Function to install packages based on distribution
install_prerequisites() {
    echo -e "${YELLOW}Installing prerequisites...${NC}"
    
    case $DISTRO in
        ubuntu|debian)
            sudo apt update
            sudo apt install -y apache2 php php-mysql php-curl php-zip php-xml mysql-server curl wget
            sudo systemctl enable apache2
            sudo systemctl start apache2
            WEBROOT="/var/www/html"
            WEBUSER="www-data"
            ;;
        centos|rhel|fedora|amzn)
            if command -v dnf &> /dev/null; then
                sudo dnf install -y httpd php php-mysqlnd php-curl php-zip php-xml mariadb-server curl wget
            else
                sudo yum install -y httpd php php-mysqlnd php-curl php-zip php-xml mariadb-server curl wget
            fi
            sudo systemctl enable httpd mariadb
            sudo systemctl start httpd mariadb
            WEBROOT="/var/www/html"
            WEBUSER="apache"
            ;;
        alpine)
            sudo apk update
            sudo apk add apache2 php php-apache2 php-mysqli php-curl php-zip php-xml mysql mysql-client curl wget
            sudo rc-service apache2 start
            sudo rc-update add apache2
            WEBROOT="/var/www/localhost/htdocs"
            WEBUSER="apache"
            ;;
        *)
            echo -e "${RED}Unsupported distribution: $DISTRO${NC}"
            echo "Please install manually: Apache/Nginx, PHP 7.4+, MySQL"
            exit 1
            ;;
    esac
    
    echo -e "${GREEN}Prerequisites installed successfully!${NC}"
}

# Function to download SecureFileHub
download_securefilehub() {
    echo -e "${YELLOW}Downloading SecureFileHub v1.1...${NC}"
    
    # Download the latest release
    if curl -L -o /tmp/filemanager.php https://github.com/jerickalmeda/SecureFileHub/releases/download/v1.1/filemanager.php; then
        echo -e "${GREEN}Download successful!${NC}"
    else
        echo -e "${RED}Download failed. Please check your internet connection.${NC}"
        exit 1
    fi
}

# Function to install SecureFileHub
install_securefilehub() {
    echo -e "${YELLOW}Installing SecureFileHub...${NC}"
    
    # Move to web directory
    sudo mv /tmp/filemanager.php $WEBROOT/
    
    # Set proper permissions
    sudo chown $WEBUSER:$WEBUSER $WEBROOT/filemanager.php
    sudo chmod 644 $WEBROOT/filemanager.php
    
    # Create secure upload directory
    sudo mkdir -p $WEBROOT/secure_uploads
    sudo chown $WEBUSER:$WEBUSER $WEBROOT/secure_uploads
    sudo chmod 755 $WEBROOT/secure_uploads
    
    echo -e "${GREEN}SecureFileHub installed successfully!${NC}"
}

# Function to configure MySQL (optional)
configure_mysql() {
    echo -e "${YELLOW}Do you want to configure MySQL? (y/n)${NC}"
    read -r response
    
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo -e "${YELLOW}Running MySQL secure installation...${NC}"
        sudo mysql_secure_installation
        
        echo -e "${YELLOW}Creating SecureFileHub database user...${NC}"
        echo "Please enter MySQL root password:"
        mysql -u root -p << EOF
CREATE USER IF NOT EXISTS 'securefile'@'localhost' IDENTIFIED BY 'SecureFile123!';
CREATE DATABASE IF NOT EXISTS securefilehub;
GRANT SELECT, INSERT, UPDATE, DELETE ON securefilehub.* TO 'securefile'@'localhost';
GRANT SHOW DATABASES ON *.* TO 'securefile'@'localhost';
FLUSH PRIVILEGES;
EOF
        
        echo -e "${GREEN}MySQL configuration completed!${NC}"
        echo -e "${BLUE}Database User: securefile${NC}"
        echo -e "${BLUE}Database Password: SecureFile123!${NC}"
        echo -e "${YELLOW}Please update these credentials in filemanager.php${NC}"
    fi
}

# Function to display final information
show_completion_info() {
    echo ""
    echo -e "${GREEN}🎉 SecureFileHub v1.1 Installation Complete!${NC}"
    echo "=================================================="
    echo ""
    echo -e "${BLUE}📁 Installation Directory:${NC} $WEBROOT/filemanager.php"
    echo -e "${BLUE}🌐 Web Access:${NC} http://$(hostname -I | awk '{print $1}')/filemanager.php"
    echo -e "${BLUE}🌐 Local Access:${NC} http://localhost/filemanager.php"
    echo ""
    echo -e "${YELLOW}🔐 Default Login Credentials:${NC}"
    echo -e "${BLUE}Username:${NC} admin"
    echo -e "${BLUE}Password:${NC} filemanager123"
    echo ""
    echo -e "${RED}⚠️  IMPORTANT SECURITY STEPS:${NC}"
    echo "1. Change default login credentials immediately"
    echo "2. Edit $WEBROOT/filemanager.php and update:"
    echo "   - FM_USERNAME and FM_PASSWORD"
    echo "   - Database credentials if using MySQL"
    echo "3. Configure firewall rules to restrict access"
    echo "4. Consider using HTTPS in production"
    echo ""
    echo -e "${GREEN}📚 Documentation:${NC} https://github.com/jerickalmeda/SecureFileHub"
    echo -e "${GREEN}🐛 Support:${NC} https://github.com/jerickalmeda/SecureFileHub/issues"
    echo ""
    echo -e "${BLUE}Thank you for using SecureFileHub! 🚀${NC}"
}

# Main installation process
main() {
    echo -e "${YELLOW}Starting installation process...${NC}"
    echo ""
    
    # Check if running as root or with sudo
    if [[ $EUID -eq 0 ]]; then
        echo -e "${RED}Please run this script as a regular user with sudo privileges${NC}"
        echo "Usage: ./install-linux.sh"
        exit 1
    fi
    
    # Check for sudo privileges
    if ! sudo -n true 2>/dev/null; then
        echo -e "${YELLOW}This script requires sudo privileges. Please enter your password when prompted.${NC}"
    fi
    
    # Installation steps
    install_prerequisites
    download_securefilehub
    install_securefilehub
    configure_mysql
    show_completion_info
}

# Run main function
main "$@"