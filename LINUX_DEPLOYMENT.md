# 🐧 SecureFileHub Linux Deployment Guide

## 📋 Quick Reference

| Distribution | Package Manager | Web Server | PHP Package | MySQL Package |
|--------------|-----------------|------------|-------------|---------------|
| Ubuntu/Debian | apt | apache2/nginx | php, php-mysql | mysql-server |
| CentOS/RHEL | yum/dnf | httpd/nginx | php, php-mysqlnd | mariadb-server |
| Fedora | dnf | httpd/nginx | php, php-mysqlnd | mariadb-server |
| Arch Linux | pacman | apache/nginx | php, php-pdo | mysql |
| openSUSE | zypper | apache2/nginx | php8, php8-mysql | mysql |
| Alpine | apk | apache2/nginx | php81, php81-pdo_mysql | mysql |

---

## 🚀 Automated Installation Scripts

### Ubuntu/Debian Quick Install
```bash
#!/bin/bash
# SecureFileHub Quick Install for Ubuntu/Debian

echo "🚀 Installing SecureFileHub on Ubuntu/Debian..."

# Update system
sudo apt update && sudo apt upgrade -y

# Install required packages
sudo apt install -y apache2 php php-mysql mysql-server git curl unzip

# Enable Apache modules
sudo a2enmod rewrite headers

# Start and enable services
sudo systemctl start apache2 mysql
sudo systemctl enable apache2 mysql

# Secure MySQL installation
echo "🔒 Please run 'sudo mysql_secure_installation' after this script"

# Download SecureFileHub
cd /tmp
wget https://github.com/jerickalmeda/SecureFileHub/releases/latest/download/filemanager.php

# Install to web directory
sudo mkdir -p /var/www/html/SecureFileHub
sudo cp filemanager.php /var/www/html/SecureFileHub/
sudo chown -R www-data:www-data /var/www/html/SecureFileHub
sudo chmod 755 /var/www/html/SecureFileHub
sudo chmod 644 /var/www/html/SecureFileHub/filemanager.php

# Create uploads directory
sudo mkdir -p /var/www/html/SecureFileHub/uploads
sudo chown www-data:www-data /var/www/html/SecureFileHub/uploads
sudo chmod 775 /var/www/html/SecureFileHub/uploads

# Configure PHP
echo "upload_max_filesize = 100M" | sudo tee -a /etc/php/$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')/apache2/conf.d/99-securefilehub.ini
echo "post_max_size = 100M" | sudo tee -a /etc/php/$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')/apache2/conf.d/99-securefilehub.ini
echo "max_execution_time = 300" | sudo tee -a /etc/php/$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')/apache2/conf.d/99-securefilehub.ini
echo "memory_limit = 256M" | sudo tee -a /etc/php/$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')/apache2/conf.d/99-securefilehub.ini

# Restart Apache
sudo systemctl restart apache2

# Create Apache virtual host
sudo tee /etc/apache2/sites-available/securefilehub.conf > /dev/null << 'EOF'
<VirtualHost *:80>
    ServerName localhost
    DocumentRoot /var/www/html/SecureFileHub
    DirectoryIndex filemanager.php
    
    <Directory /var/www/html/SecureFileHub>
        AllowOverride All
        Require local
        Require ip 192.168.0.0/16
        Require ip 10.0.0.0/8
    </Directory>
    
    # Security headers
    Header always set X-Content-Type-Options nosniff
    Header always set X-Frame-Options DENY
    Header always set X-XSS-Protection "1; mode=block"
    
    ErrorLog ${APACHE_LOG_DIR}/securefilehub_error.log
    CustomLog ${APACHE_LOG_DIR}/securefilehub_access.log combined
</VirtualHost>
EOF

# Enable site
sudo a2ensite securefilehub
sudo systemctl reload apache2

echo "✅ SecureFileHub installed successfully!"
echo "🌐 Access: http://localhost/filemanager.php"
echo "👤 Default login: admin / filemanager123"
echo "⚠️  IMPORTANT: Change the default password immediately!"
echo "📝 Configuration file: /var/www/html/SecureFileHub/filemanager.php"
```

### CentOS/RHEL/Fedora Quick Install
```bash
#!/bin/bash
# SecureFileHub Quick Install for CentOS/RHEL/Fedora

echo "🚀 Installing SecureFileHub on CentOS/RHEL/Fedora..."

# Detect package manager
if command -v dnf &> /dev/null; then
    PKG_MGR="dnf"
elif command -v yum &> /dev/null; then
    PKG_MGR="yum"
else
    echo "❌ Neither dnf nor yum found. Exiting."
    exit 1
fi

# Update system
sudo $PKG_MGR update -y

# Install required packages
sudo $PKG_MGR install -y httpd php php-mysqlnd mariadb-server git curl wget

# Start and enable services
sudo systemctl start httpd mariadb
sudo systemctl enable httpd mariadb

# Configure firewall
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

# Secure MariaDB installation
echo "🔒 Please run 'sudo mysql_secure_installation' after this script"

# Download SecureFileHub
cd /tmp
wget https://github.com/jerickalmeda/SecureFileHub/releases/latest/download/filemanager.php

# Install to web directory
sudo mkdir -p /var/www/html/SecureFileHub
sudo cp filemanager.php /var/www/html/SecureFileHub/
sudo chown -R apache:apache /var/www/html/SecureFileHub
sudo chmod 755 /var/www/html/SecureFileHub
sudo chmod 644 /var/www/html/SecureFileHub/filemanager.php

# Create uploads directory
sudo mkdir -p /var/www/html/SecureFileHub/uploads
sudo chown apache:apache /var/www/html/SecureFileHub/uploads
sudo chmod 775 /var/www/html/SecureFileHub/uploads

# Configure PHP
echo "upload_max_filesize = 100M" | sudo tee -a /etc/php.d/99-securefilehub.ini
echo "post_max_size = 100M" | sudo tee -a /etc/php.d/99-securefilehub.ini
echo "max_execution_time = 300" | sudo tee -a /etc/php.d/99-securefilehub.ini
echo "memory_limit = 256M" | sudo tee -a /etc/php.d/99-securefilehub.ini

# Configure SELinux (if enabled)
if command -v getenforce &> /dev/null && [[ $(getenforce) == "Enforcing" ]]; then
    sudo setsebool -P httpd_can_network_connect 1
    sudo setsebool -P httpd_enable_homedirs 1
    sudo semanage fcontext -a -t httpd_exec_t "/var/www/html/SecureFileHub/filemanager.php"
    sudo restorecon -v /var/www/html/SecureFileHub/filemanager.php
fi

# Restart httpd
sudo systemctl restart httpd

echo "✅ SecureFileHub installed successfully!"
echo "🌐 Access: http://localhost/SecureFileHub/filemanager.php"
echo "👤 Default login: admin / filemanager123"
echo "⚠️  IMPORTANT: Change the default password immediately!"
echo "📝 Configuration file: /var/www/html/SecureFileHub/filemanager.php"
```

---

## 🐳 Docker Deployment

### Quick Docker Run
```bash
# Simple deployment
docker run -d \
  --name securefilehub \
  -p 8080:80 \
  -v $(pwd)/files:/var/www/html/files \
  -v $(pwd)/uploads:/var/www/html/uploads \
  jerickalmeda/securefilehub:latest

# Access: http://localhost:8080/filemanager.php
```

### Docker Compose with MySQL
```bash
# Clone repository
git clone https://github.com/jerickalmeda/SecureFileHub.git
cd SecureFileHub

# Start services
docker-compose up -d

# Access SecureFileHub: http://localhost:8080/filemanager.php
# Access phpMyAdmin: http://localhost:8081
```

### Docker Build from Source
```bash
# Clone and build
git clone https://github.com/jerickalmeda/SecureFileHub.git
cd SecureFileHub

# Build image
docker build -t securefilehub:local .

# Run container
docker run -d \
  --name securefilehub-local \
  -p 8080:80 \
  -v $(pwd)/files:/var/www/html/files \
  securefilehub:local
```

---

## 🔧 Nginx Configuration

### Ubuntu/Debian Nginx Setup
```bash
# Install Nginx and PHP-FPM
sudo apt install -y nginx php-fpm php-mysql

# Create Nginx configuration
sudo tee /etc/nginx/sites-available/securefilehub > /dev/null << 'EOF'
server {
    listen 80;
    server_name localhost filemanager.local;
    root /var/www/html/SecureFileHub;
    index filemanager.php;
    
    # Access control
    allow 127.0.0.1;
    allow 192.168.0.0/16;
    allow 10.0.0.0/8;
    deny all;
    
    # Main location
    location / {
        try_files $uri $uri/ =404;
    }
    
    # PHP processing
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
    
    # Security headers
    add_header X-Content-Type-Options nosniff always;
    add_header X-Frame-Options DENY always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    
    # Logging
    access_log /var/log/nginx/securefilehub_access.log;
    error_log /var/log/nginx/securefilehub_error.log;
    
    # Security: Hide Nginx version
    server_tokens off;
    
    # File upload size
    client_max_body_size 100M;
}
EOF

# Enable site
sudo ln -s /etc/nginx/sites-available/securefilehub /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx php8.1-fpm
```

---

## 🔒 Security Hardening

### File Permissions
```bash
# Set secure permissions
sudo chown -R www-data:www-data /var/www/html/SecureFileHub  # Ubuntu/Debian
sudo chown -R apache:apache /var/www/html/SecureFileHub      # CentOS/RHEL

# Secure file permissions
sudo find /var/www/html/SecureFileHub -type f -exec chmod 644 {} \;
sudo find /var/www/html/SecureFileHub -type d -exec chmod 755 {} \;
sudo chmod 644 /var/www/html/SecureFileHub/filemanager.php

# Uploads directory (if needed)
sudo chmod 775 /var/www/html/SecureFileHub/uploads
```

### Firewall Configuration
```bash
# UFW (Ubuntu/Debian)
sudo ufw allow ssh
sudo ufw allow 'Apache Full'  # or 'Nginx Full'
sudo ufw enable

# Firewalld (CentOS/RHEL/Fedora)
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

# iptables (Advanced)
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
sudo iptables -A INPUT -j DROP
```

### SSL/TLS with Let's Encrypt
```bash
# Install Certbot
sudo apt install certbot python3-certbot-apache  # Ubuntu/Debian
sudo dnf install certbot python3-certbot-apache  # Fedora

# Get certificate
sudo certbot --apache -d yourdomain.com

# Auto-renewal
sudo crontab -e
# Add: 0 12 * * * /usr/bin/certbot renew --quiet
```

---

## 🔍 Monitoring & Logging

### Log Monitoring
```bash
# Apache logs
sudo tail -f /var/log/apache2/securefilehub_access.log
sudo tail -f /var/log/apache2/securefilehub_error.log

# Nginx logs
sudo tail -f /var/log/nginx/securefilehub_access.log
sudo tail -f /var/log/nginx/securefilehub_error.log

# PHP logs
sudo tail -f /var/log/php_errors.log
```

### System Monitoring
```bash
# Install monitoring tools
sudo apt install htop iotop nethogs  # Ubuntu/Debian
sudo dnf install htop iotop nethogs  # Fedora

# Monitor resources
htop           # System resources
iotop          # Disk I/O
nethogs        # Network usage
```

---

## 🚨 Troubleshooting

### Common Issues

#### PHP not working
```bash
# Check PHP version
php -v

# Check PHP modules
php -m | grep -E '(pdo|mysql)'

# Restart services
sudo systemctl restart apache2 php8.1-fpm  # Ubuntu/Debian
sudo systemctl restart httpd               # CentOS/RHEL
```

#### Permission errors
```bash
# Check ownership
ls -la /var/www/html/SecureFileHub/

# Fix permissions
sudo chown -R www-data:www-data /var/www/html/SecureFileHub
sudo chmod -R 755 /var/www/html/SecureFileHub
```

#### SELinux issues (CentOS/RHEL)
```bash
# Check SELinux status
getenforce

# Check denials
sudo ausearch -m AVC -ts recent

# Allow HTTP connections
sudo setsebool -P httpd_can_network_connect 1
```

---

## 📊 Performance Optimization

### PHP-FPM Tuning
```bash
# Edit PHP-FPM configuration
sudo nano /etc/php/8.1/fpm/pool.d/www.conf

# Optimize settings
pm = dynamic
pm.max_children = 50
pm.start_servers = 5
pm.min_spare_servers = 5
pm.max_spare_servers = 35
pm.process_idle_timeout = 10s
```

### Database Optimization
```bash
# MySQL configuration
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf

# Add optimizations
[mysqld]
innodb_buffer_pool_size = 256M
query_cache_size = 32M
query_cache_limit = 2M
max_connections = 100
```

---

## 🔄 Backup & Updates

### Backup Script
```bash
#!/bin/bash
# Backup SecureFileHub

BACKUP_DIR="/backup/securefilehub"
DATE=$(date +%Y%m%d_%H%M%S)

# Create backup directory
mkdir -p $BACKUP_DIR

# Backup files
tar -czf $BACKUP_DIR/securefilehub_files_$DATE.tar.gz /var/www/html/SecureFileHub

# Backup database (if using)
mysqldump -u root -p securefilehub > $BACKUP_DIR/securefilehub_db_$DATE.sql

# Keep only last 7 days
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
```

### Update Process
```bash
# Download latest version
cd /tmp
wget https://github.com/jerickalmeda/SecureFileHub/releases/latest/download/filemanager.php

# Backup current version
sudo cp /var/www/html/SecureFileHub/filemanager.php /var/www/html/SecureFileHub/filemanager.php.backup

# Update
sudo cp filemanager.php /var/www/html/SecureFileHub/
sudo chown www-data:www-data /var/www/html/SecureFileHub/filemanager.php
sudo chmod 644 /var/www/html/SecureFileHub/filemanager.php
```

---

**🐧 Linux deployment made easy! Choose the method that best fits your environment.**