<?php
session_start();
require_once 'config.php';

$error = '';
$success = '';

if($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = mysqli_real_escape_string($conn, trim($_POST['username']));
    $password = mysqli_real_escape_string($conn, trim($_POST['password']));
    $confirm_password = mysqli_real_escape_string($conn, trim($_POST['confirm_password']));
    $usertype = 'teacher'; // Default usertype for public signup
    $status = 'active';
    $createdby = 'self-registration';
    $datecreated = date('Y-m-d H:i:s');
    
    // Validation
    if(empty($username) || empty($password) || empty($confirm_password)) {
        $error = 'All fields are required';
    } elseif(strlen($username) < 4) {
        $error = 'Username must be at least 4 characters long';
    } elseif(strlen($password) < 6) {
        $error = 'Password must be at least 6 characters long';
    } elseif($password !== $confirm_password) {
        $error = 'Passwords do not match';
    } else {
        // Check if username already exists
        $check_query = "SELECT * FROM tblaccounts WHERE username='$username'";
        $check_result = mysqli_query($conn, $check_query);
        
        if(mysqli_num_rows($check_result) > 0) {
            $error = 'Username already exists. Please choose a different username.';
        } else {
            // Insert new account
            $insert_query = "INSERT INTO tblaccounts (username, password, usertype, status, createdby, datecreated) 
                            VALUES ('$username', '$password', '$usertype', '$status', '$createdby', '$datecreated')";
            
            if(mysqli_query($conn, $insert_query)) {
                $success = 'Account created successfully! Redirecting to login...';
                header("refresh:2;url=index.php");
            } else {
                $error = 'Error creating account. Please try again.';
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Palatiw Elementary</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            display: flex;
            overflow: hidden;
        }

        .container {
            display: flex;
            width: 100%;
            height: 100vh;
        }

        /* Left Panel - Illustration Area */
        .left-panel {
            flex: 1;
            background: linear-gradient(135deg, rgba(0, 70, 67, 0.95) 0%, rgba(0, 70, 67, 0.85) 100%),
                        url('palatiw school2.jpeg') center/cover;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 60px;
            position: relative;
        }

        .left-panel::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 30% 50%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            pointer-events: none;
        }

        .illustration-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 30px;
            padding: 80px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            text-align: center;
            max-width: 500px;
            width: 100%;
            position: relative;
            z-index: 1;
        }

        .illustration-placeholder {
            color: #ffffff;
            font-size: 48px;
            font-weight: 700;
            letter-spacing: 2px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            line-height: 1.3;
        }

        /* Right Panel - Signup Form */
        .right-panel {
            flex: 1;
            background: #f0ede5;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 60px;
            overflow-y: auto;
        }

        .signup-card {
            background: #f0ede5;
            border-radius: 30px;
            padding: 50px 45px;
            box-shadow: 12px 12px 24px rgba(0, 0, 0, 0.1),
                -12px -12px 24px rgba(255, 255, 255, 0.8);
            max-width: 420px;
            width: 100%;
        }

        .logo-section {
            text-align: center;
            margin-bottom: 40px;
        }

        .school-logo {
            width: 100px;
            height: 100px;
            margin: 0 auto 20px;
            border-radius: 50%;
            background: white;
            padding: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .school-logo img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .title {
            font-size: 28px;
            font-weight: 600;
            color: #004643;
            margin-bottom: 8px;
        }

        .subtitle {
            font-size: 14px;
            color: #666;
            font-weight: 400;
            line-height: 1.4;
        }

        .error, .success {
            padding: 12px 20px;
            border-radius: 15px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .error {
            background: #ffebee;
            color: #c62828;
        }

        .success {
            background: #e8f5e9;
            color: #2e7d32;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            color: #555;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .input-field {
            width: 100%;
            padding: 14px 18px;
            font-size: 15px;
            border: none;
            border-radius: 15px;
            background: #f0ede5;
            box-shadow: inset 6px 6px 12px rgba(0, 0, 0, 0.08),
                inset -6px -6px 12px rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
            color: #333;
            font-family: inherit;
        }

        .input-field:focus {
            outline: none;
            box-shadow: inset 8px 8px 16px rgba(0, 0, 0, 0.1),
                inset -8px -8px 16px rgba(255, 255, 255, 0.9);
        }

        .password-requirements {
            font-size: 12px;
            color: #777;
            margin-top: 6px;
            line-height: 1.4;
        }

        .button-group {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-top: 30px;
        }

        .btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .btn-primary {
            background: #004643;
            color: white;
            box-shadow: 0 6px 20px rgba(0, 70, 67, 0.3);
        }

        .btn-primary:hover {
            background: #003a37;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 70, 67, 0.4);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .btn-secondary {
            background: #e7e5e4;
            color: #333;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .btn-secondary:hover {
            background: #ddd9d7;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .btn-secondary:active {
            transform: translateY(0);
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #666;
        }

        .login-link a {
            color: #004643;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        /* Responsive Design */
        @media (max-width: 968px) {
            .container {
                flex-direction: column;
            }

            .left-panel {
                padding: 40px;
                min-height: 250px;
            }

            .illustration-card {
                padding: 50px;
            }

            .illustration-placeholder {
                font-size: 32px;
            }

            .right-panel {
                padding: 40px 20px;
            }

            .signup-card {
                padding: 40px 30px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Left Panel -->
        <div class="left-panel">
            <div class="illustration-card">
                <p class="illustration-placeholder">Join Palatiw Elementary School</p>
            </div>
        </div>

        <!-- Right Panel -->
        <div class="right-panel">
            <div class="signup-card">
                <div class="logo-section">
                    <div class="school-logo">
                        <img src="logo.png" alt="School Logo" />
                    </div>
                    <h1 class="title">Create Account</h1>
                    <p class="subtitle">Supply Consolidation and Management System</p>
                </div>

                <?php if($error): ?>
                    <div class="error"><?php echo htmlspecialchars($error); ?></div>
                <?php endif; ?>

                <?php if($success): ?>
                    <div class="success"><?php echo htmlspecialchars($success); ?></div>
                <?php endif; ?>

                <form method="POST" action="">
                    <div class="form-group">
                        <label class="form-label" for="username">Username</label>
                        <input
                            type="text"
                            id="username"
                            name="username"
                            class="input-field"
                            placeholder="Choose a username"
                            required
                            minlength="4"
                        />
                        <p class="password-requirements">Minimum 4 characters</p>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="password">Password</label>
                        <input
                            type="password"
                            id="password"
                            name="password"
                            class="input-field"
                            placeholder="Create a password"
                            required
                            minlength="6"
                        />
                        <p class="password-requirements">Minimum 6 characters</p>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="confirm_password">Confirm Password</label>
                        <input
                            type="password"
                            id="confirm_password"
                            name="confirm_password"
                            class="input-field"
                            placeholder="Re-enter your password"
                            required
                        />
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">Create Account</button>
                        <button type="button" class="btn btn-secondary" onclick="location.href='index.php'">Back to Login</button>
                    </div>
                </form>

                <div class="login-link">
                    Already have an account? <a href="index.php">Sign in here</a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Real-time password match validation
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirm_password');

        confirmPassword.addEventListener('input', function() {
            if(password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity('Passwords do not match');
            } else {
                confirmPassword.setCustomValidity('');
            }
        });

        password.addEventListener('input', function() {
            if(confirmPassword.value && password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity('Passwords do not match');
            } else {
                confirmPassword.setCustomValidity('');
            }
        });
    </script>
</body>
</html>