<?php
session_start();
require_once 'config.php';

$error = '';

if($_SERVER['REQUEST_METHOD'] == 'POST') {
    $user = mysqli_real_escape_string($conn, $_POST['username']);
    $pass = mysqli_real_escape_string($conn, $_POST['password']);
    
    $query = "SELECT * FROM tblaccounts WHERE username='$user' AND password='$pass' AND status='active'";
    $result = mysqli_query($conn, $query);
    
    if($result && mysqli_num_rows($result) == 1) {
        $userdata = mysqli_fetch_assoc($result);
        $_SESSION['username'] = $userdata['username'];
        $_SESSION['usertype'] = $userdata['usertype'];
        $_SESSION['logged_in'] = true;
        
        if($userdata['usertype'] == 'admin') {
            header('Location: admin_dashboard.php');
            exit();
        } else {
            header('Location: select_grade.php');
            exit();
        }
    } else {
        $error = 'Invalid username or password';
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Palatiw Elementary - Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #004643 0%, #006b66 50%, #004643 100%);
            position: relative;
            overflow-x: hidden;
            padding: 20px;
        }

        body::before {
            content: '';
            position: absolute;
            width: 600px;
            height: 600px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            top: -200px;
            right: -200px;
            border-radius: 50%;
            pointer-events: none;
        }

        body::after {
            content: '';
            position: absolute;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.08) 0%, transparent 70%);
            bottom: -100px;
            left: -100px;
            border-radius: 50%;
            pointer-events: none;
        }

        .login-container {
            background: #ffffff;
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            max-width: 480px;
            width: 100%;
            padding: 48px 40px;
            position: relative;
            z-index: 1;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header-section {
            text-align: center;
            margin-bottom: 40px;
        }

        .logo-container {
            width: 170px;
            height: 170px;
            margin: 0 auto 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .logo-container img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .system-title {
            font-size: 24px;
            font-weight: 700;
            color: #004643;
            margin-bottom: 8px;
            line-height: 1.3;
        }

        .system-subtitle {
            font-size: 15px;
            font-weight: 500;
            color: #004643;
            margin-bottom: 4px;
        }

        .system-description {
            font-size: 13px;
            color: #64748b;
            font-weight: 400;
            line-height: 1.5;
        }

        .divider {
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, transparent, #004643, transparent);
            margin: 24px auto;
        }

        .error-message {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: #991b1b;
            padding: 14px 18px;
            border-radius: 12px;
            margin-bottom: 24px;
            font-size: 14px;
            text-align: center;
            border-left: 4px solid #dc2626;
            font-weight: 500;
            box-shadow: 0 2px 8px rgba(220, 38, 38, 0.15);
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 8px;
            letter-spacing: 0.3px;
        }

        .input-wrapper {
            position: relative;
        }

        .form-input {
            width: 100%;
            padding: 14px 16px;
            font-size: 15px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            background: #f8fafc;
            transition: all 0.3s ease;
            color: #1e293b;
            font-family: inherit;
            font-weight: 400;
        }

        .form-input:focus {
            outline: none;
            border-color: #004643;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(0, 70, 67, 0.1);
        }

        .form-input::placeholder {
            color: #94a3b8;
        }

        .checkbox-container {
            display: flex;
            align-items: center;
            margin-bottom: 32px;
            cursor: pointer;
            user-select: none;
        }

        .checkbox-container input[type="checkbox"] {
            width: 20px;
            height: 20px;
            margin-right: 10px;
            cursor: pointer;
            accent-color: #004643;
            border-radius: 4px;
        }

        .checkbox-label {
            font-size: 14px;
            color: #475569;
            font-weight: 500;
            cursor: pointer;
        }

        .submit-button {
            width: 100%;
            padding: 16px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: inherit;
            background: linear-gradient(135deg, #004643 0%, #006b66 100%);
            color: #ffffff;
            box-shadow: 0 4px 16px rgba(0, 70, 67, 0.3);
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .submit-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 24px rgba(0, 70, 67, 0.4);
            background: linear-gradient(135deg, #003a37 0%, #005550 100%);
        }

        .submit-button:active {
            transform: translateY(0);
            box-shadow: 0 2px 12px rgba(0, 70, 67, 0.3);
        }

        .footer-text {
            text-align: center;
            margin-top: 32px;
            font-size: 13px;
            color: #64748b;
            line-height: 1.6;
        }

        /* Responsive Design */
        @media (max-width: 640px) {
            .login-container {
                padding: 36px 28px;
            }

            .system-title {
                font-size: 20px;
            }

            .system-subtitle {
                font-size: 14px;
            }

            .system-description {
                font-size: 12px;
            }

            .logo-container {
                width: 120px;
                height: 120px;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 16px;
            }

            .login-container {
                padding: 32px 24px;
            }

            .system-title {
                font-size: 18px;
            }

            .header-section {
                margin-bottom: 32px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="header-section">
            <div class="logo-container">
                <img src="logo.png" alt="Palatiw Elementary School Logo" />
            </div>
            <h1 class="system-title">Palatiw Elementary</h1>
            <p class="system-subtitle">Supply Consolidation and Management System</p>
            <div class="divider"></div>
            <p class="system-description">Please sign in to access your account</p>
        </div>

        <?php if($error): ?>
            <div class="error-message"><?php echo htmlspecialchars($error); ?></div>
        <?php endif; ?>

        <form method="POST" action="">
            <div class="form-group">
                <label class="form-label" for="username">Username</label>
                <div class="input-wrapper">
                    <input
                        type="text"
                        id="username"
                        name="username"
                        class="form-input"
                        placeholder="Enter your username"
                        value="<?php echo isset($_POST['username']) ? htmlspecialchars($_POST['username']) : ''; ?>"
                        required
                        autocomplete="username"
                    />
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <div class="input-wrapper">
                    <input
                        type="password"
                        id="password"
                        name="password"
                        class="form-input"
                        placeholder="Enter your password"
                        required
                        autocomplete="current-password"
                    />
                </div>
            </div>

            <label class="checkbox-container">
                <input type="checkbox" id="showPassword" />
                <span class="checkbox-label">Show Password</span>
            </label>

            <button type="submit" class="submit-button">Sign In</button>
        </form>

        <p class="footer-text">
            Authorized personnel only.<br>
            Please contact your administrator for access.
        </p>
    </div>

    <script>
        const showPasswordCheckbox = document.getElementById("showPassword");
        const passwordInput = document.getElementById("password");

        showPasswordCheckbox.addEventListener("change", function () {
            passwordInput.type = this.checked ? "text" : "password";
        });
    </script>
</body>
</html>