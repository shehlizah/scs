# SCS HQ - Phalcon 4.0+ Migration - Troubleshooting Guide

## What We Fixed

1. ✅ Apache/Nginx routing (.htaccess files)
2. ✅ Phalcon 3.x → 4.0+ Framework compatibility
3. ✅ Router URI handling
4. ✅ Config/Services/Loader classes
5. ✅ Database connection setup
6. ✅ Security and Exception plugins
7. ✅ Error reporting and logging

## To Debug 500 Error

### Step 1: Check Debug Page
Visit: `https://scs.hitechmain.com/debug.php`

This will show you:
- Phalcon version
- .env file status
- Database connection
- All config files
- Controller files

### Step 2: Check Error Logs
Look in: `app/logs/`
- Check latest date folder
- Look for `.log` files
- Also check `php_errors.log` if created

### Step 3: View Actual Error
Now when you visit `https://scs.hitechmain.com/`
You should see the actual error message displayed on screen (if error_reporting is enabled).

## Common Issues & Solutions

### Issue: Database Connection Failed
**Solution:**
- Verify DB host `10.184.0.3` is accessible
- Check credentials in `app/config/env/.env`
- Ensure database `scs_db` exists
- Verify user `scs_hq` has proper permissions

### Issue: Controller/Model Not Found
**Solution:**
- Check file names match class names
- Verify files are in correct directories
- Check namespace declarations

### Issue: Session/Auth Issues
**Solution:**
- Ensure session directory is writable: `app/logs/`
- Check `app/config/env/.env` has session settings
- Clear session cookies in browser

### Issue: Permission Denied Errors
**Solution:**
```bash
# On server, set proper permissions:
chmod -R 755 app/
chmod -R 755 public/
chmod -R 775 app/logs/
chmod -R 775 cache/
```

### Issue: View/Template Errors
**Solution:**
- Check Volt template syntax in `app/views/`
- Ensure cache directory is writable: `cache/`
- Clear cache: Delete all files in `cache/`

## Files Modified

### Configuration Files
- `/app/config/config.php` - Phalcon 4.0+ Config class compatibility
- `/app/config/loader.php` - Autoloader v4 compatibility
- `/app/config/router.php` - URI parameter handling
- `/app/config/services.php` - Database & service setup

### Entry Point
- `/public/index.php` - Error reporting enabled, better error messages

### Plugins
- `/app/plugins/SecurityPlugin.php` - InjectionAwareInterface implementation
- `/app/plugins/ExceptionPlugin.php` - InjectionAwareInterface implementation

### Web Server
- `/.htaccess` - Root rewrite rules
- `/public/.htaccess` - Public rewrite rules

### New Files
- `/public/debug.php` - Debugging utility
- `/public/diagnostics.php` - Database settings check
- `/public/show_all_settings.php` - List all DB settings

## Next Steps

1. Run `https://scs.hitechmain.com/debug.php`
2. Check if all items show ✓
3. If database fails, troubleshoot connection
4. Visit `https://scs.hitechmain.com/`
5. Read any error messages displayed
6. Fix specific controller/model issues as they appear

## Database Settings To Verify

The app needs these in `app/config/env/.env`:
```
DB_HOST=10.184.0.3
DB_USER=scs_hq
DB_PASS=P@ssw0rd@2o24
DB_NAME=scs_db
BASE_URI=https://scs.hitechmain.com
BASE_URI_FILE=https://scs.hitechmain.com/
```

Also check if `settings` table in database has correct values for:
- Base URLs
- API endpoints
- Configuration values

## Support

If you see a specific error, please share:
1. The exact error message
2. The file name and line number
3. Output from `/debug.php`
4. Any entries in `/app/logs/`
