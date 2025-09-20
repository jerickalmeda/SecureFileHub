# Contributing to SecureFileHub

🎉 Thank you for considering contributing to SecureFileHub! We welcome contributions from the community and are grateful for your support.

## 📋 Table of Contents
- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Issue Guidelines](#issue-guidelines)

## 🤝 Code of Conduct

This project and everyone participating in it is governed by our commitment to creating a welcoming and inclusive environment. Please be respectful and constructive in all interactions.

## 🚀 How Can I Contribute?

### 🐛 Reporting Bugs
- Use the bug report template
- Include detailed reproduction steps
- Provide environment information
- Add screenshots if applicable

### 💡 Suggesting Features
- Use the feature request template
- Explain the use case clearly
- Consider implementation complexity
- Check if similar features exist

### 📝 Documentation
- Improve README sections
- Add code comments
- Create examples and tutorials
- Fix typos and grammar

### 💻 Code Contributions
- Bug fixes
- New features
- Performance improvements
- Security enhancements

## 🛠️ Development Setup

### Prerequisites
- PHP 7.4 or higher
- Web server (Apache, Nginx, or IIS)
- MySQL/MariaDB (for database features)
- Git

### Setup Steps
```bash
# Clone your fork
git clone https://github.com/yourusername/SecureFileHub.git
cd SecureFileHub

# Set up your development environment
# Option 1: Laragon (Windows)
# Copy to C:\laragon\www\SecureFileHub\

# Option 2: XAMPP
# Copy to your XAMPP htdocs folder

# Option 3: Local server
php -S localhost:8000 filemanager.php
```

### Testing Your Changes
1. Test with default configuration
2. Test with custom database settings
3. Test file operations (upload, edit, delete)
4. Test database operations (if applicable)
5. Test security features
6. Test in different browsers
7. Test responsive design

## 🔄 Pull Request Process

### 1. Fork and Clone
```bash
# Fork the repository on GitHub
# Clone your fork
git clone https://github.com/yourusername/SecureFileHub.git
cd SecureFileHub
```

### 2. Create Feature Branch
```bash
# Create a descriptive branch name
git checkout -b feature/amazing-new-feature
# or
git checkout -b fix/critical-bug-fix
```

### 3. Make Changes
- Follow coding standards
- Add comments for complex logic
- Test thoroughly
- Update documentation if needed

### 4. Commit Changes
```bash
# Use conventional commit messages
git commit -m "feat: add file compression feature"
git commit -m "fix: resolve security vulnerability in upload"
git commit -m "docs: update installation guide"
```

### 5. Push and Create PR
```bash
git push origin feature/amazing-new-feature
# Create pull request on GitHub
```

### 6. PR Requirements
- [ ] Clear description of changes
- [ ] Reference related issues
- [ ] Include testing steps
- [ ] Update documentation if needed
- [ ] Pass all checks

## 📏 Coding Standards

### PHP Code Style
```php
<?php
// Use meaningful variable names
$fileManager = new FileManager();

// Add docblocks for functions
/**
 * Sanitize file path to prevent directory traversal
 * @param string $path Raw file path
 * @return string Sanitized path
 */
function sanitizePath($path) {
    // Implementation
}

// Use consistent indentation (4 spaces)
if ($condition) {
    // Code here
}
```

### Security Guidelines
- Always validate user input
- Use prepared statements for SQL
- Implement CSRF protection
- Sanitize file paths
- Validate file types
- Use secure session management

### JavaScript Guidelines
```javascript
// Use camelCase for variables
const fileManager = document.getElementById('fileManager');

// Add comments for complex logic
function toggleEditor() {
    // Toggle editor visibility and handle state
}

// Use consistent formatting
if (condition) {
    // Code here
}
```

## 📋 Issue Guidelines

### Before Creating an Issue
1. Search existing issues
2. Check documentation
3. Test with latest version
4. Gather necessary information

### Issue Quality
- Use appropriate template
- Provide clear title
- Include environment details
- Add reproduction steps
- Attach relevant files/screenshots

## 🏷️ Commit Message Convention

We use conventional commits for better changelog generation:

- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation changes
- `style:` Code style changes
- `refactor:` Code refactoring
- `test:` Test additions/changes
- `chore:` Maintenance tasks

Examples:
```bash
feat: add file compression support
fix: resolve CSRF token validation issue
docs: update security configuration guide
style: improve code formatting consistency
refactor: optimize database connection handling
```

## 🎯 Areas for Contribution

### High Priority
- Security improvements
- Performance optimizations
- Mobile responsiveness
- Accessibility features

### Medium Priority
- Additional file type support
- UI/UX improvements
- Code editor enhancements
- Database feature additions

### Documentation
- Installation guides
- Configuration examples
- Security best practices
- Troubleshooting guides

## 🆘 Getting Help

- **Documentation**: Check the README and Wiki
- **Issues**: Search existing issues
- **Discussions**: Use GitHub Discussions for questions
- **Email**: Contact maintainers for security issues

## 🙏 Recognition

Contributors will be recognized in:
- README contributor section
- Release notes
- GitHub contributor stats

Thank you for helping make SecureFileHub better! 🚀