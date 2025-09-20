# 🗂️ SecureFileHub

[![PHP Version](https://img.shields.io/badge/PHP-7.4%2B-blue.svg)](https://php.net)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/yourusername/SecureFileHub.svg)](https://github.com/yourusername/SecureFileHub/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/yourusername/SecureFileHub.svg)](https://github.com/yourusername/SecureFileHub/issues)

> **Secure PHP File Manager with Database Integration**

A comprehensive, single-file PHP web application that functions as a secure online file manager with integrated MySQL database management capabilities, fully compatible with Windows Server environments.

## 🚀 Quick Demo

![SecureFileHub Demo](https://via.placeholder.com/800x400/2563eb/ffffff?text=SecureFileHub+Demo)

**Key Highlights:**
- 🔐 **Single File Deployment** - Just upload one PHP file and you're ready!
- 🎨 **Monaco Editor Integration** - Professional code editing with VS Code features
- 🗄️ **Database Management** - Full MySQL administration capabilities
- 🛡️ **Enterprise Security** - CSRF protection, session management, path sanitization
- 📱 **Responsive Design** - Works on desktop, tablet, and mobile devices

## ✨ Features

### 📁 File Manage## 📦 Repository

**GitHub**: [SecureFileHub](https://github.com/yourusername/SecureFileHub)

**Clone the repository:**
```bash
git clone https://github.com/yourusername/SecureFileHub.git
cd SecureFileHub
```

**Download latest release:**
```bash
wget https://github.com/yourusername/SecureFileHub/releases/latest/download/filemanager.php
```

**Topics**: `php` `file-manager` `database-manager` `monaco-editor` `mysql` `web-application` `security` `single-file` `windows-server` `laragon`

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Commit your changes**: `git commit -m 'Add amazing feature'`
4. **Push to the branch**: `git push origin feature/amazing-feature`
5. **Open a Pull Request**

### Development Setup
```bash
# Clone your fork
git clone https://github.com/yourusername/SecureFileHub.git
cd SecureFileHub

# Set up development environment
# (Laragon, XAMPP, or your preferred local server)

# Make your changes and test
# Submit a pull request
```

### Reporting Issues
Found a bug or have a feature request? Please [open an issue](https://github.com/yourusername/SecureFileHub/issues) with:
- Detailed description
- Steps to reproduce (for bugs)
- Your environment (PHP version, OS, browser)
- Screenshots (if applicable)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.e Authentication** - Login protection with session management
- **File Operations** - Upload, download, create, edit, rename, and delete files/folders
- **Code Editor** - Built-in Monaco Editor (VS Code editor) with syntax highlighting
- **Tree Navigation** - Sidebar directory tree structure for easy navigation
- **File Previews** - Support for text files, images, and code files
- **Security** - CSRF protection, directory traversal prevention, path sanitization

### 🗄️ Database Management
- **MySQL Integration** - Connect and manage MySQL databases
- **Query Executor** - Execute SQL queries with results display
- **Table Browser** - Browse table structures and data
- **Export Features** - Export query results to CSV/JSON
- **Query History** - Track and reuse recent queries
- **Database Tree** - Navigate databases and tables in sidebar

### 🔒 Security Features
- Session-based authentication with timeout
- CSRF token protection
- Path sanitization and directory traversal prevention
- Configurable access credentials
- File type restrictions for editing
- Secure database connections with PDO

## 📋 Requirements

- **PHP 7.4 or higher**
- **Web server** (Apache, Nginx, or IIS)
- **MySQL/MariaDB** (optional, for database features)
- **Modern web browser** with JavaScript enabled

## 🚀 Quick Installation

### Method 1: GitHub Download
```bash
# Clone the repository
git clone https://github.com/yourusername/SecureFileHub.git
cd SecureFileHub

# Copy to your web server
cp filemanager.php /path/to/your/webserver/
```

### Method 2: Direct Download
1. Download `filemanager.php` from [Releases](https://github.com/yourusername/SecureFileHub/releases)
2. Upload to your web server directory
3. Access via web browser: `http://yourserver/filemanager.php`
4. Login with default credentials (see Configuration section)

### Method 3: Laragon/XAMPP Setup
1. Clone or download to your web root (e.g., `C:\laragon\www\SecureFileHub\`)
2. Start your web server and MySQL (if using database features)
3. Access: `http://localhost/SecureFileHub/filemanager.php`

### Default Login Credentials
- **Username**: `admin`
- **Password**: `filemanager123`
- ⚠️ **Important**: Change these credentials immediately after installation!

## ⚙️ Configuration

### 🔐 Changing Admin Credentials

Edit the following lines in `filemanager.php` (around line 5-6):

```php
// Configuration
define('FM_USERNAME', 'admin');           // Change this username
define('FM_PASSWORD', 'filemanager123');  // Change this password
```

**Example:**
```php
define('FM_USERNAME', 'myusername');
define('FM_PASSWORD', 'MySecurePassword123!');
```

### 🗄️ Database Configuration

Edit the database settings in `filemanager.php` (around line 11-14):

```php
// Database Configuration
define('DB_HOST', 'localhost');     // Database server host
define('DB_USERNAME', 'root');      // Database username
define('DB_PASSWORD', '');          // Database password
define('DB_NAME', 'mysql');         // Default database
```

**Example for Production:**
```php
define('DB_HOST', 'mysql.example.com');
define('DB_USERNAME', 'dbuser');
define('DB_PASSWORD', 'SecureDBPassword123!');
define('DB_NAME', 'production_db');
```

### 🕒 Session Configuration

Modify session timeout (around line 7):

```php
define('FM_SESSION_TIMEOUT', 3600); // 1 hour in seconds
```

**Examples:**
- 30 minutes: `1800`
- 2 hours: `7200`
- 8 hours: `28800`

### 📂 Root Directory

By default, the file manager operates in its installation directory. To change the root directory, modify line 8:

```php
define('FM_ROOT_PATH', __DIR__);
```

**Example to set custom root:**
```php
define('FM_ROOT_PATH', 'C:\inetpub\wwwroot\myfiles');
```

## 🎯 Usage Guide

### 📁 File Manager Features

1. **Navigation**
   - Use the left sidebar tree to navigate directories
   - Click folder icons to expand/collapse
   - Breadcrumb shows current path

2. **File Operations**
   - **Upload**: Use the upload form in the top section
   - **Create Folder**: Enter folder name and click Create
   - **Create File**: Enter filename with extension
   - **Edit Files**: Click ✏️ icon next to text files
   - **Download**: Click 📥 icon next to files
   - **Rename**: Click ✏️ and modify the name
   - **Delete**: Click 🗑️ (requires confirmation)

3. **Code Editor**
   - Supports syntax highlighting for PHP, HTML, CSS, JS, Python, Java, C++, SQL
   - Auto-completion and error detection
   - Save with Ctrl+S or Save button
   - Format code with Format button
   - Toggle visibility with Hide/Show Editor

### 🗄️ Database Manager Features

1. **Connection**
   - Switch to Database tab in main content area
   - Select database from sidebar or dropdown
   - Connection status shown in info panel

2. **Query Execution**
   - Write SQL queries in the text area
   - Select target database
   - Use Quick Query buttons for common operations
   - View results in formatted table

3. **Table Management**
   - Browse table structure and data
   - Use table browser for quick SELECT queries
   - Export results to CSV or JSON
   - View table structure with DESCRIBE

4. **Query History**
   - Recent queries saved automatically
   - Click history items to reload queries
   - Stored in browser localStorage

## 🛡️ Security Best Practices

### 🔒 Password Security
```php
// Use strong passwords with mixed characters
define('FM_PASSWORD', 'MyStr0ng!P@ssw0rd#2024');
```

### 🌐 Web Server Configuration

#### Apache (.htaccess)
Create `.htaccess` in the same directory:
```apache
# Restrict access to PHP files
<Files "*.php">
    Require ip 192.168.1.0/24  # Your IP range
    # Or specific IPs: Require ip 192.168.1.100
</Files>

# Security headers
Header always set X-Content-Type-Options nosniff
Header always set X-Frame-Options DENY
Header always set X-XSS-Protection "1; mode=block"
```

#### Nginx
```nginx
location /filemanager.php {
    allow 192.168.1.0/24;  # Your IP range
    deny all;
    
    add_header X-Content-Type-Options nosniff;
    add_header X-Frame-Options DENY;
    add_header X-XSS-Protection "1; mode=block";
}
```

### 🔐 Database Security
```php
// Use dedicated database user with limited privileges
define('DB_USERNAME', 'filemanager_user');  // Not root
define('DB_PASSWORD', 'StrongDBPassword123!');

// Grant only necessary privileges:
// GRANT SELECT, INSERT, UPDATE, DELETE ON myapp.* TO 'filemanager_user'@'localhost';
```

## 🚨 Troubleshooting

### Common Issues

#### ❌ "Parse error: syntax error"
- Check PHP version (requires 7.4+)
- Verify file encoding is UTF-8
- Check for missing semicolons or brackets

#### ❌ "Database connection failed"
- Verify MySQL service is running
- Check database credentials in configuration
- Confirm MySQL port (default 3306) is accessible
- Test connection: `mysql -h localhost -u username -p`

#### ❌ "Permission denied" errors
- Check file/folder permissions
- On Windows: Ensure IIS_IUSRS has appropriate permissions
- On Linux: Use `chmod 755` for directories, `chmod 644` for files

#### ❌ "File upload failed"
- Check `upload_max_filesize` in php.ini
- Verify `post_max_size` is larger than `upload_max_filesize`
- Ensure target directory is writable

#### ❌ Monaco Editor not loading
- Check internet connection (loads from CDN)
- Verify browser JavaScript is enabled
- Try different browser
- Check browser console for errors

### PHP Configuration

Recommended php.ini settings:
```ini
upload_max_filesize = 100M
post_max_size = 100M
max_execution_time = 300
memory_limit = 256M
session.gc_maxlifetime = 3600
```

## 🎨 Customization

### 🎭 Changing Theme Colors

Edit the Tailwind CSS classes in the HTML sections:

```php
// Change header color (around line 500)
<header class="bg-purple-600 text-white shadow-lg">  // Was bg-blue-600

// Change button colors
<button class="bg-green-500 hover:bg-green-600">    // Success buttons
<button class="bg-red-500 hover:bg-red-600">        // Danger buttons
```

### 📝 Adding File Types

To add support for new file types in the editor:

```php
// Add to languageMap array (around line 1200)
const languageMap = {
    'php': 'php',
    'js': 'javascript',
    'py': 'python',
    'rb': 'ruby',        // Add Ruby support
    'go': 'go',          // Add Go support
    // ... existing entries
};

// Add to editableExts array (around line 150)
$editableExts = ['php', 'html', 'css', 'js', 'json', 'xml', 'txt', 'md', 'py', 'java', 'c', 'cpp', 'h', 'sql', 'ini', 'conf', 'log', 'rb', 'go'];
```

### 🎯 Custom Quick Queries

Add custom SQL quick queries:

```php
// Add buttons in the Database Manager section
<button onclick="setQuickQuery('SHOW PROCESSLIST;')" class="bg-gray-500 text-white px-2 py-1 rounded text-xs hover:bg-gray-600">Show Processes</button>
<button onclick="setQuickQuery('SHOW STATUS;')" class="bg-gray-500 text-white px-2 py-1 rounded text-xs hover:bg-gray-600">Show Status</button>
```

## 📊 Performance Optimization

### For Large Directories
- Increase PHP memory limit: `memory_limit = 512M`
- Adjust max execution time: `max_execution_time = 600`
- Consider pagination for large file lists

### For Database Operations
- Use LIMIT clauses for large result sets
- Enable query cache in MySQL
- Use appropriate indexes on frequently queried tables

## 🔄 Updates and Maintenance

### Backup Recommendations
1. **Regular backups** of the `filemanager.php` file with your configurations
2. **Database backups** if using database features
3. **File system backups** of managed directories

### Update Process
1. Backup current configuration settings
2. Download new version of `filemanager.php`
3. Restore your configuration settings
4. Test functionality

## � Repository

**GitHub**: [SecureFileHub](https://github.com/yourusername/SecureFileHub)

**Clone the repository:**
```bash
git clone https://github.com/yourusername/SecureFileHub.git
cd SecureFileHub
```

**Topics**: `php` `file-manager` `database-manager` `monaco-editor` `mysql` `web-application` `security` `single-file` `windows-server` `laragon`

## �📄 License

This project is open source under the MIT License. Feel free to modify and distribute according to your needs.

## 🆘 Support

### Getting Help
1. Check the troubleshooting section above
2. Verify your PHP and MySQL versions
3. Check web server error logs
4. Test with default configuration first

### Reporting Issues
When reporting issues, please include:
- PHP version
- Web server type and version
- MySQL version (if using database features)
- Browser and version
- Complete error messages
- Steps to reproduce

---

<div align="center">

**🗂️ SecureFileHub**

*Secure File & Database Management Made Simple*

[![GitHub](https://img.shields.io/github/stars/yourusername/SecureFileHub?style=social)](https://github.com/yourusername/SecureFileHub)
[![Twitter Follow](https://img.shields.io/twitter/follow/yourusername?style=social)](https://twitter.com/yourusername)

**⭐ Star this project if you find it useful!**

[Report Bug](https://github.com/yourusername/SecureFileHub/issues) • [Request Feature](https://github.com/yourusername/SecureFileHub/issues) • [Documentation](https://github.com/yourusername/SecureFileHub/wiki)

</div>

---

**Made with ❤️ by the SecureFileHub team**

Last updated: September 2025