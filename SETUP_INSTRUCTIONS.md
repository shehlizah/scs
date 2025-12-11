# Setup Instructions for scs.hitechmain.com

## Current Issue
The website is showing directory listing instead of running the application.

## Solution Steps

### Option 1: Using cPanel / Hosting Control Panel (Easiest)

1. **Login to your hosting control panel** (cPanel, Plesk, etc.)

2. **Change Document Root:**
   - Go to "Domains" or "Web Hosting" section
   - Find `scs.hitechmain.com`
   - Click "Manage" or "Settings"
   - Change **Document Root** from:
     - Current: `/public_html/` or `/scs_hq_20251211/`
     - To: `/public_html/public/` or `/scs_hq_20251211/public/`
   - Save changes

3. **Disable Directory Indexing:**
   - In cPanel, go to "Indexes" under Files section
   - Select your domain
   - Choose "No Indexing"
   - Save

4. **Ensure mod_rewrite is enabled:**
   - Usually enabled by default in cPanel
   - If not, contact your hosting provider

### Option 2: Using Apache Configuration File (VirtualHost)

If you have SSH/root access, edit Apache config:

```bash
# Find and edit your Apache config
# Usually in: /etc/apache2/sites-available/ or /etc/httpd/conf.d/

<VirtualHost *:80>
    ServerName scs.hitechmain.com
    ServerAlias www.scs.hitechmain.com
    
    # IMPORTANT: Point to the public folder
    DocumentRoot /path/to/scs_hq_20251211/public
    
    <Directory /path/to/scs_hq_20251211/public>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog ${APACHE_LOG_DIR}/scs_error.log
    CustomLog ${APACHE_LOG_DIR}/scs_access.log combined
</VirtualHost>
```

Then reload Apache:
```bash
sudo a2enmod rewrite
sudo systemctl reload apache2
```

### Option 3: If You Can't Change DocumentRoot

If you can't change the document root, move files:

```bash
# Connect via SSH or FTP
cd /path/to/web/root
# Move all files from public/ to root
mv public/* .
mv public/.htaccess .
# Update paths in index.php
```

Then edit `index.php` line 6:
```php
define('BASE_PATH', dirname(__DIR__));  // OLD
define('BASE_PATH', __DIR__);           // NEW
```

## Database Setup

Your database config is in: `app/config/env/.env`

**Current settings:**
- Host: 10.184.0.3
- Database: scs_db
- User: scs_hq
- Password: (configured)

**To upload database:**
1. Use phpMyAdmin or MySQL command line
2. Create database if not exists: `CREATE DATABASE scs_db;`
3. Import your SQL file:
   ```bash
   mysql -h 10.184.0.3 -u scs_hq -p scs_db < your_database.sql
   ```

## Verification

After setup, visit: `https://scs.hitechmain.com`

You should see your application, not a file listing.

## Troubleshooting

**Still seeing directory listing?**
- Clear browser cache
- Check .htaccess files are uploaded (they might be hidden)
- Verify mod_rewrite is enabled: `apache2ctl -M | grep rewrite`

**500 Internal Server Error?**
- Check Apache error logs
- Verify file permissions (folders: 755, files: 644)
- Check .env file has correct database credentials

**Need help?** Check logs at: `app/logs/`
