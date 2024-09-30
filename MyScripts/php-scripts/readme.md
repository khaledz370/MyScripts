# Bypass WordPress Login Page Script

This script allows users to bypass the WordPress login page by entering a specific password. If the correct password is provided, the user is granted access to the admin area.

## Features

- **Session Management:** Tracks login attempts and implements a lockout mechanism after three failed attempts.
- **Admin Access:** Retrieves the first user of a specified role (default is administrator) and logs them in automatically.
- **User-Friendly Interface:** A simple HTML form for password input.

## Usage

1. **Download the Script:**
   The `nolog.php` file is available in the Git repository. Download it to the root folder of your WordPress installation.

2. **Modify the Password:**
   Open `nolog.php` and replace `your_password_here` with your desired password.

3. **Modify User Type:**
   You can change the user role in the script by adjusting the `'role' => 'administrator'` parameter. Available roles include: `administrator`, `editor`, `author`, `contributor`, and `subscriber`.

4. **Access the Script:**
   Navigate to `http://your-wordpress-site/nolog.php` to use the script.

## Important Notes

- This script should only be used in emergency situations to regain access to your WordPress admin area.
- Ensure the script is removed after use to maintain the security of your site.
