<?php
session_start();
require_once 'config.php';

// Check if user is logged in and is admin
if(!isset($_SESSION['logged_in']) || $_SESSION['usertype'] != 'admin') {
    header('Location: index.php');
    exit();
}

$success = '';
$error = '';

// Handle account deletion
if(isset($_GET['delete_id'])) {
    $delete_id = mysqli_real_escape_string($conn, $_GET['delete_id']);
    $delete_query = "DELETE FROM tblaccounts WHERE id='$delete_id'";
    if(mysqli_query($conn, $delete_query)) {
        $success = 'Account deleted successfully!';
    } else {
        $error = 'Error deleting account.';
    }
}

// Handle single log deletion
if(isset($_GET['delete_log_id'])) {
    $delete_log_id = mysqli_real_escape_string($conn, $_GET['delete_log_id']);
    $delete_log_query = "DELETE FROM tbllogs WHERE id='$delete_log_id'";
    if(mysqli_query($conn, $delete_log_query)) {
        $success = 'Activity log deleted successfully!';
    } else {
        $error = 'Error deleting activity log.';
    }
}

// Handle multiple log deletions
if(isset($_POST['delete_multiple_logs']) && isset($_POST['log_ids'])) {
    $log_ids = $_POST['log_ids'];
    $ids_to_delete = array_map(function($id) use ($conn) {
        return mysqli_real_escape_string($conn, $id);
    }, $log_ids);
    
    $ids_string = implode(',', $ids_to_delete);
    $delete_multiple_query = "DELETE FROM tbllogs WHERE id IN ($ids_string)";
    
    if(mysqli_query($conn, $delete_multiple_query)) {
        $count = count($log_ids);
        $success = "$count activity log(s) deleted successfully!";
    } else {
        $error = 'Error deleting activity logs.';
    }
}

// Handle add/edit account
if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['action'])) {
    $username = mysqli_real_escape_string($conn, trim($_POST['username']));
    $password = mysqli_real_escape_string($conn, trim($_POST['password']));
    $usertype = mysqli_real_escape_string($conn, $_POST['usertype']);
    $section = mysqli_real_escape_string($conn, trim($_POST['section']));
    $status = mysqli_real_escape_string($conn, $_POST['status']);
    
    if($_POST['action'] == 'add') {
        $createdby = $_SESSION['username'];
        $datecreated = date('Y-m-d H:i:s');
        
        $check_query = "SELECT * FROM tblaccounts WHERE username='$username'";
        $check_result = mysqli_query($conn, $check_query);
        
        if(mysqli_num_rows($check_result) > 0) {
            $error = 'Username already exists!';
        } else {
            $insert_query = "INSERT INTO tblaccounts (username, password, usertype, section, status, createdby, datecreated) 
                            VALUES ('$username', '$password', '$usertype', '$section', '$status', '$createdby', '$datecreated')";
            if(mysqli_query($conn, $insert_query)) {
                $success = 'Account added successfully!';
            } else {
                $error = 'Error adding account.';
            }
        }
    } elseif($_POST['action'] == 'edit') {
        $edit_id = mysqli_real_escape_string($conn, $_POST['edit_id']);
        $update_query = "UPDATE tblaccounts SET 
                        username='$username', 
                        password='$password', 
                        usertype='$usertype', 
                        section='$section', 
                        status='$status' 
                        WHERE id='$edit_id'";
        if(mysqli_query($conn, $update_query)) {
            $success = 'Account updated successfully!';
        } else {
            $error = 'Error updating account.';
        }
    }
}

// Fetch all accounts
$accounts_query = "SELECT * FROM tblaccounts ORDER BY id DESC";
$accounts_result = mysqli_query($conn, $accounts_query);

// Fetch recent logs with search and filter
$log_search = '';
$log_filter = '';
$log_where_conditions = [];

if(isset($_GET['log_search']) && !empty($_GET['log_search'])) {
    $log_search = mysqli_real_escape_string($conn, $_GET['log_search']);
    $log_where_conditions[] = "(section LIKE '%$log_search%' OR student_name LIKE '%$log_search%' OR created_by LIKE '%$log_search%')";
}

if(isset($_GET['log_filter']) && !empty($_GET['log_filter'])) {
    $log_filter = mysqli_real_escape_string($conn, $_GET['log_filter']);
    $log_where_conditions[] = "action_type = '$log_filter'";
}

$log_where_clause = '';
if(count($log_where_conditions) > 0) {
    $log_where_clause = 'WHERE ' . implode(' AND ', $log_where_conditions);
}

$logs_query = "SELECT * FROM tbllogs $log_where_clause ORDER BY date_created DESC LIMIT 100";
$logs_result = mysqli_query($conn, $logs_query);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Palatiw Elementary</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: #f8fafb;
            min-height: 100vh;
            color: #1e293b;
        }

        /* Header Styles */
        .header {
            background: linear-gradient(135deg, #004643 0%, #006b66 100%);
            color: white;
            padding: 24px 48px;
            box-shadow: 0 4px 20px rgba(0, 70, 67, 0.15);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .school-logo-header {
            width: 70px;
            height: 70px;
            background: white;
            border-radius: 16px;
            padding: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }

        .school-logo-header img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .school-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .school-name {
            font-size: 28px;
            font-weight: 700;
            letter-spacing: -0.5px;
            line-height: 1.2;
        }

        .school-subtitle {
            font-size: 14px;
            opacity: 0.9;
            font-weight: 400;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 24px;
        }

        .user-info {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 2px;
        }

        .user-role {
            font-size: 12px;
            opacity: 0.8;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .user-name {
            font-size: 16px;
            font-weight: 600;
        }

        .btn-logout {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
            padding: 10px 24px;
            border-radius: 12px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-logout:hover {
            background: rgba(255, 255, 255, 0.25);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        /* Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 48px;
        }

        .page-header {
            margin-bottom: 36px;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 8px;
        }

        .page-description {
            font-size: 15px;
            color: #64748b;
            font-weight: 400;
        }

        /* Dashboard Cards - 2x2 Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
            margin-bottom: 48px;
        }

        .card {
            background: white;
            border-radius: 20px;
            padding: 32px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
            border: 1px solid #f1f5f9;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #004643, #006b66);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0, 70, 67, 0.12);
            border-color: #e2e8f0;
        }

        .card:hover::before {
            transform: scaleX(1);
        }

        .card-icon {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, #004643 0%, #006b66 100%);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0, 70, 67, 0.2);
        }
        
        .card-icon i {
            color: white;
        }

        .card h2 {
            font-size: 20px;
            color: #1e293b;
            margin-bottom: 12px;
            font-weight: 700;
        }

        .card p {
            color: #64748b;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 24px;
        }

        .btn-card {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #004643;
            color: white;
            padding: 12px 24px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-card:hover {
            background: #003a37;
            transform: translateX(4px);
            box-shadow: 0 4px 12px rgba(0, 70, 67, 0.3);
        }

        /* Section Styles */
        .section {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
            border: 1px solid #f1f5f9;
            margin-bottom: 32px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f1f5f9;
        }

        .section-title {
            font-size: 24px;
            color: #1e293b;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-title i {
            color: #004643;
            font-size: 28px;
        }

        /* Alerts */
        .alert {
            padding: 16px 20px;
            border-radius: 12px;
            margin-bottom: 24px;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 12px;
            border: 1px solid;
        }

        .alert i {
            font-size: 18px;
        }

        .alert-success {
            background: #f0fdf4;
            color: #166534;
            border-color: #bbf7d0;
        }

        .alert-error {
            background: #fef2f2;
            color: #991b1b;
            border-color: #fecaca;
        }

        /* Buttons */
        .btn-add {
            background: #004643;
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-add:hover {
            background: #003a37;
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(0, 70, 67, 0.25);
        }

        .btn-add i {
            font-size: 14px;
        }

        .btn-delete-selected {
            background: #991b1b;
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            opacity: 0.5;
            pointer-events: none;
        }

        .btn-delete-selected.active {
            opacity: 1;
            pointer-events: auto;
        }

        .btn-delete-selected.active:hover {
            background: #7f1d1d;
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(153, 27, 27, 0.25);
        }

        /* Search and Filter */
        .search-filter-container {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }

        .search-input, .filter-select {
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 14px;
            transition: all 0.3s;
            font-family: inherit;
            background: white;
        }

        .search-input {
            flex: 1;
            min-width: 280px;
        }

        .search-input:focus, .filter-select:focus {
            outline: none;
            border-color: #004643;
            box-shadow: 0 0 0 3px rgba(0, 70, 67, 0.1);
        }

        .btn-search, .btn-clear {
            padding: 12px 24px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-search {
            background: #004643;
            color: white;
        }

        .btn-search:hover {
            background: #003a37;
            box-shadow: 0 4px 12px rgba(0, 70, 67, 0.25);
        }

        .btn-clear {
            background: #f1f5f9;
            color: #475569;
        }

        .btn-clear:hover {
            background: #e2e8f0;
        }

        /* Table Styles */
        .table-container {
            overflow-x: auto;
            border-radius: 12px;
            border: 1px solid #f1f5f9;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th {
            background: #f8fafc;
            color: #1e293b;
            padding: 16px 20px;
            text-align: left;
            font-weight: 700;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #e2e8f0;
        }

        table td {
            padding: 16px 20px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
            color: #334155;
        }

        table tbody tr {
            transition: all 0.2s ease;
        }

        table tbody tr:hover {
            background: #f8fafc;
        }

        table tbody tr:last-child td {
            border-bottom: none;
        }

        .status-badge, .action-badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .status-active {
            background: #f0fdf4;
            color: #166534;
        }

        .status-inactive {
            background: #fef2f2;
            color: #991b1b;
        }

        .action-badge.add {
            background: #eff6ff;
            color: #1e40af;
        }

        .action-badge.edit {
            background: #fff7ed;
            color: #c2410c;
        }

        .action-badge.delete {
            background: #fef2f2;
            color: #991b1b;
        }

        .btn-edit, .btn-delete {
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s ease;
            margin-right: 8px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-edit {
            background: #eff6ff;
            color: #1e40af;
        }

        .btn-edit:hover {
            background: #1e40af;
            color: white;
        }

        .btn-delete {
            background: #fef2f2;
            color: #991b1b;
        }

        .btn-delete:hover {
            background: #991b1b;
            color: white;
        }

        /* Checkbox Styles */
        .checkbox-cell {
            width: 50px;
            text-align: center;
        }

        .log-checkbox {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #004643;
        }

        #selectAll {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #004643;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .modal-content {
            background: white;
            margin: 5% auto;
            padding: 48px;
            border-radius: 24px;
            max-width: 540px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.3s ease;
        }

        @keyframes slideUp {
            from {
                transform: translateY(40px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f1f5f9;
        }

        .modal-header h2 {
            font-size: 24px;
            color: #1e293b;
            font-weight: 700;
        }

        .close {
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: #94a3b8;
            cursor: pointer;
            transition: all 0.2s ease;
            border-radius: 8px;
        }

        .close:hover {
            background: #f1f5f9;
            color: #475569;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            color: #334155;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .form-input, .form-select {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 14px;
            transition: all 0.3s ease;
            font-family: inherit;
            background: white;
        }

        .form-input:focus, .form-select:focus {
            outline: none;
            border-color: #004643;
            box-shadow: 0 0 0 3px rgba(0, 70, 67, 0.1);
        }

        .modal-buttons {
            display: flex;
            gap: 12px;
            margin-top: 32px;
        }

        .btn-submit, .btn-cancel {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-submit {
            background: #004643;
            color: white;
        }

        .btn-submit:hover {
            background: #003a37;
            box-shadow: 0 4px 12px rgba(0, 70, 67, 0.25);
        }

        .btn-cancel {
            background: #f1f5f9;
            color: #475569;
        }

        .btn-cancel:hover {
            background: #e2e8f0;
        }

        .no-data {
            text-align: center;
            padding: 60px 20px;
            color: #94a3b8;
        }

        .no-data i {
            font-size: 56px;
            margin-bottom: 16px;
            color: #cbd5e1;
        }

        .no-data p {
            font-size: 15px;
            font-weight: 500;
        }

        /* Action buttons container */
        .log-actions {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
            align-items: center;
        }

        /* Delete Confirmation Modal Styles */
        .delete-modal-content {
            background: white;
            margin: 10% auto;
            padding: 0;
            border-radius: 24px;
            max-width: 480px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.3s ease;
            overflow: hidden;
        }

        .delete-modal-icon {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            padding: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .delete-icon-circle {
            width: 80px;
            height: 80px;
            background: #991b1b;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 0 0 0 rgba(153, 27, 27, 0.4);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 0 0 15px rgba(153, 27, 27, 0);
            }
        }

        .delete-icon-circle i {
            font-size: 36px;
            color: white;
        }

        .delete-modal-body {
            padding: 32px 40px 40px 40px;
            text-align: center;
        }

        .delete-modal-title {
            font-size: 24px;
            color: #1e293b;
            font-weight: 700;
            margin-bottom: 12px;
        }

        .delete-modal-message {
            font-size: 15px;
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 28px;
        }

        .delete-modal-buttons {
            display: flex;
            gap: 12px;
        }

        .btn-confirm-delete, .btn-cancel-delete {
            flex: 1;
            padding: 14px 24px;
            border: none;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-confirm-delete {
            background: #991b1b;
            color: white;
        }

        .btn-confirm-delete:hover {
            background: #7f1d1d;
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(153, 27, 27, 0.3);
        }

        .btn-cancel-delete {
            background: #f1f5f9;
            color: #475569;
        }

        .btn-cancel-delete:hover {
            background: #e2e8f0;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .container {
                padding: 32px 24px;
            }

            .header {
                padding: 20px 24px;
            }

            .section {
                padding: 32px 24px;
            }
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }

            .header-left {
                flex-direction: column;
                gap: 16px;
            }

            .school-info {
                align-items: center;
            }

            .school-name {
                font-size: 22px;
            }

            .header-right {
                flex-direction: column;
                gap: 16px;
                width: 100%;
            }

            .user-info {
                align-items: center;
            }

            .btn-logout {
                width: 100%;
                justify-content: center;
            }

            /* Stack cards in single column on mobile */
            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .section-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }

            .search-filter-container {
                flex-direction: column;
            }

            .search-input {
                min-width: 100%;
            }

            .modal-content, .delete-modal-content {
                margin: 10% 20px;
            }

            .modal-content {
                padding: 32px 24px;
            }

            .delete-modal-body {
                padding: 24px 20px 32px 20px;
            }

            table {
                font-size: 13px;
            }

            table th, table td {
                padding: 12px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 24px 16px;
            }

            .header {
                padding: 16px;
            }

            .school-logo-header {
                width: 56px;
                height: 56px;
            }

            .school-name {
                font-size: 20px;
            }

            .section {
                padding: 24px 16px;
            }

            .page-title {
                font-size: 26px;
            }

            .delete-modal-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="header-content">
            <div class="header-left">
                <div class="school-logo-header">
                    <img src="logo.png" alt="Palatiw Elementary School Logo" />
                </div>
                <div class="school-info">
                    <div class="school-name">Palatiw Elementary School</div>
                    <div class="school-subtitle">Supply Consolidation and Management System</div>
                </div>
            </div>
            <div class="header-right">
                <div class="user-info">
                    <div class="user-role">Administrator</div>
                    <div class="user-name"><?php echo htmlspecialchars($_SESSION['username']); ?></div>
                </div>
                <button class="btn-logout" onclick="location.href='logout.php'">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </button>
            </div>
        </div>
    </div>

    <!-- Main Container -->
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">Admin Dashboard</h1>
            <p class="page-description">Manage accounts, monitor activities, and access system features</p>
        </div>

        <!-- Dashboard Cards - 2x2 Grid -->
        <div class="dashboard-grid">
            <!-- Row 1, Card 1: Grade Levels -->
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-graduation-cap"></i>
                </div>
                <h2>Grade Levels</h2>
                <p>Manage grade levels from Grade 1 to Grade 6. Access supply lists and requirements for each grade.</p>
                <a href="select_grade.php" class="btn-card">
                    Manage Grades
                    <i class="fas fa-arrow-right"></i>
                </a>
            </div>

            <!-- Row 1, Card 2: Student Summary -->
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <h2>Student Summary</h2>
                <p>View total enrollment per grade and section with live charts and a gender breakdown across all grades.</p>
                <a href="student_summary.php" class="btn-card">
                    View Summary
                    <i class="fas fa-arrow-right"></i>
                </a>
            </div>

            <!-- Row 2, Card 1: Activity Logs -->
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h2>Activity Logs</h2>
                <p>View all system activities including additions, edits, and deletions across all sections.</p>
                <a href="#logs" class="btn-card" onclick="document.getElementById('logs').scrollIntoView({behavior: 'smooth'})">
                    View Logs
                    <i class="fas fa-arrow-right"></i>
                </a>
            </div>
            
            <!-- Row 2, Card 2: Consolidated Report -->
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-print"></i>
                </div>
                <h2>Consolidated Report</h2>
                <p>Generate printable reports for selected grades and sections. Choose what to include and print in batch.</p>
                <a href="consolidated_report.php" class="btn-card">
                    Generate Report
                    <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </div>

        <!-- Accounts Management Section -->
        <div class="section" id="accounts">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-users"></i>
                    Accounts Management
                </h2>
                <button class="btn-add" onclick="openAddModal()">
                    <i class="fas fa-plus"></i>
                    Add New Account
                </button>
            </div>

            <?php if($success): ?>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <?php echo htmlspecialchars($success); ?>
                </div>
            <?php endif; ?>

            <?php if($error): ?>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <?php echo htmlspecialchars($error); ?>
                </div>
            <?php endif; ?>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>User Type</th>
                            <th>Section</th>
                            <th>Status</th>
                            <th>Created By</th>
                            <th>Date Created</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if(mysqli_num_rows($accounts_result) > 0): ?>
                            <?php while($account = mysqli_fetch_assoc($accounts_result)): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($account['id']); ?></td>
                                <td><strong><?php echo htmlspecialchars($account['username']); ?></strong></td>
                                <td><?php echo htmlspecialchars($account['usertype']); ?></td>
                                <td><?php echo htmlspecialchars($account['section'] ?? 'Not Assigned'); ?></td>
                                <td>
                                    <span class="status-badge <?php echo $account['status'] == 'active' ? 'status-active' : 'status-inactive'; ?>">
                                        <?php echo htmlspecialchars($account['status']); ?>
                                    </span>
                                </td>
                                <td><?php echo htmlspecialchars($account['createdby']); ?></td>
                                <td><?php echo htmlspecialchars($account['datecreated']); ?></td>
                                <td>
                                    <button class="btn-edit" onclick='openEditModal(<?php echo json_encode($account); ?>)'>
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="btn-delete" onclick="confirmDelete(<?php echo $account['id']; ?>)">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </td>
                            </tr>
                            <?php endwhile; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="8" class="no-data">
                                    <i class="fas fa-users"></i>
                                    <p>No accounts found</p>
                                </td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Activity Logs Section -->
        <div class="section" id="logs">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-history"></i>
                    Activity Logs
                </h2>
            </div>

            <?php if($success): ?>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <?php echo htmlspecialchars($success); ?>
                </div>
            <?php endif; ?>

            <?php if($error): ?>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <?php echo htmlspecialchars($error); ?>
                </div>
            <?php endif; ?>

            <form method="GET" action="">
                <div class="search-filter-container">
                    <input type="text" 
                           name="log_search" 
                           class="search-input" 
                           placeholder="Search by section, student name, or username..."
                           value="<?php echo htmlspecialchars($log_search); ?>">
                    
                    <select name="log_filter" class="filter-select">
                        <option value="">All Actions</option>
                        <option value="ADD" <?php echo $log_filter == 'ADD' ? 'selected' : ''; ?>>Add</option>
                        <option value="EDIT" <?php echo $log_filter == 'EDIT' ? 'selected' : ''; ?>>Edit</option>
                        <option value="DELETE" <?php echo $log_filter == 'DELETE' ? 'selected' : ''; ?>>Delete</option>
                    </select>
                    
                    <button type="submit" class="btn-search">
                        <i class="fas fa-search"></i> Search
                    </button>
                    
                    <?php if(!empty($log_search) || !empty($log_filter)): ?>
                        <button type="button" class="btn-clear" onclick="location.href='admin_dashboard.php#logs'">
                            <i class="fas fa-times"></i> Clear
                        </button>
                    <?php endif; ?>
                </div>
            </form>

            <form method="POST" id="deleteLogsForm">
                <div class="log-actions">
                    <button type="button" class="btn-delete-selected" id="deleteSelectedBtn" onclick="confirmDeleteSelected()">
                        <i class="fas fa-trash-alt"></i>
                        Delete Selected (<span id="selectedCount">0</span>)
                    </button>
                </div>

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th class="checkbox-cell">
                                    <input type="checkbox" id="selectAll" onchange="toggleSelectAll()">
                                </th>
                                <th>Date & Time</th>
                                <th>Action</th>
                                <th>Section</th>
                                <th>Student Name</th>
                                <th>Details</th>
                                <th>Created By</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if(mysqli_num_rows($logs_result) > 0): ?>
                                <?php while($log = mysqli_fetch_assoc($logs_result)): ?>
                                <tr>
                                    <td class="checkbox-cell">
                                        <input type="checkbox" class="log-checkbox" name="log_ids[]" value="<?php echo $log['id']; ?>" onchange="updateDeleteButton()">
                                    </td>
                                    <td><?php echo htmlspecialchars($log['date_created']); ?></td>
                                    <td>
                                        <span class="action-badge <?php echo strtolower($log['action_type']); ?>">
                                            <?php echo htmlspecialchars($log['action_type']); ?>
                                        </span>
                                    </td>
                                    <td><strong><?php echo htmlspecialchars($log['section']); ?></strong></td>
                                    <td><?php echo htmlspecialchars($log['student_name'] ?? 'N/A'); ?></td>
                                    <td><?php echo htmlspecialchars($log['details']); ?></td>
                                    <td><?php echo htmlspecialchars($log['created_by']); ?></td>
                                    <td>
                                        <button type="button" class="btn-delete" onclick="confirmDeleteLog(<?php echo $log['id']; ?>)">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </td>
                                </tr>
                                <?php endwhile; ?>
                            <?php else: ?>
                                <tr>
                                    <td colspan="8" class="no-data">
                                        <i class="fas fa-clipboard-list"></i>
                                        <p>No activity logs found</p>
                                    </td>
                                </tr>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </div>
            </form>
        </div>
    </div>

    <!-- Add/Edit Account Modal -->
    <div id="accountModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle">Add New Account</h2>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <form method="POST" action="">
                <input type="hidden" name="action" id="formAction" value="add">
                <input type="hidden" name="edit_id" id="editId">

                <div class="form-group">
                    <label class="form-label" for="modal_username">Username</label>
                    <input type="text" class="form-input" id="modal_username" name="username" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="modal_password">Password</label>
                    <input type="password" class="form-input" id="modal_password" name="password" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="modal_usertype">User Type</label>
                    <select class="form-select" id="modal_usertype" name="usertype" required>
                        <option value="teacher">Teacher</option>
                        <option value="admin">Admin</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label" for="modal_section">Section</label>
                    <input type="text" class="form-input" id="modal_section" name="section" placeholder="e.g., Sampaguita, Rose">
                </div>

                <div class="form-group">
                    <label class="form-label" for="modal_status">Status</label>
                    <select class="form-select" id="modal_status" name="status" required>
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                    </select>
                </div>

                <div class="modal-buttons">
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-save"></i> Save Account
                    </button>
                    <button type="button" class="btn-cancel" onclick="closeModal()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteConfirmModal" class="modal">
        <div class="delete-modal-content">
            <div class="delete-modal-icon">
                <div class="delete-icon-circle">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
            </div>
            <div class="delete-modal-body">
                <h2 class="delete-modal-title">Confirm Deletion</h2>
                <p class="delete-modal-message" id="deleteMessage">
                    Are you sure you want to delete this activity log? This action cannot be undone.
                </p>
                <div class="delete-modal-buttons">
                    <button class="btn-cancel-delete" onclick="closeDeleteModal()">
                        <i class="fas fa-times"></i>
                        Cancel
                    </button>
                    <button class="btn-confirm-delete" id="confirmDeleteBtn">
                        <i class="fas fa-trash-alt"></i>
                        Yes, Delete
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        let deleteAction = null;

        function openAddModal() {
            document.getElementById('modalTitle').textContent = 'Add New Account';
            document.getElementById('formAction').value = 'add';
            document.getElementById('modal_username').value = '';
            document.getElementById('modal_password').value = '';
            document.getElementById('modal_usertype').value = 'teacher';
            document.getElementById('modal_section').value = '';
            document.getElementById('modal_status').value = 'active';
            document.getElementById('accountModal').style.display = 'block';
        }

        function openEditModal(account) {
            document.getElementById('modalTitle').textContent = 'Edit Account';
            document.getElementById('formAction').value = 'edit';
            document.getElementById('editId').value = account.id;
            document.getElementById('modal_username').value = account.username;
            document.getElementById('modal_password').value = account.password;
            document.getElementById('modal_usertype').value = account.usertype;
            document.getElementById('modal_section').value = account.section || '';
            document.getElementById('modal_status').value = account.status;
            document.getElementById('accountModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('accountModal').style.display = 'none';
        }

        function confirmDelete(id) {
            deleteAction = function() {
                window.location.href = 'admin_dashboard.php?delete_id=' + id;
            };
            
            document.getElementById('deleteMessage').textContent = 
                'Are you sure you want to delete this account? This action cannot be undone.';
            document.getElementById('deleteConfirmModal').style.display = 'block';
            
            document.getElementById('confirmDeleteBtn').onclick = function() {
                if(deleteAction) deleteAction();
            };
        }

        function confirmDeleteLog(id) {
            deleteAction = function() {
                window.location.href = 'admin_dashboard.php?delete_log_id=' + id + '#logs';
            };
            
            document.getElementById('deleteMessage').textContent = 
                'Are you sure you want to delete this activity log? This action cannot be undone.';
            document.getElementById('deleteConfirmModal').style.display = 'block';
            
            document.getElementById('confirmDeleteBtn').onclick = function() {
                if(deleteAction) deleteAction();
            };
        }

        function confirmDeleteSelected() {
            const checkboxes = document.querySelectorAll('.log-checkbox:checked');
            
            if(checkboxes.length === 0) {
                alert('Please select at least one activity log to delete.');
                return;
            }
            
            const count = checkboxes.length;
            const message = count === 1 
                ? 'Are you sure you want to delete this activity log? This action cannot be undone.' 
                : `Are you sure you want to delete ${count} activity logs? This action cannot be undone.`;
            
            deleteAction = function() {
                const form = document.getElementById('deleteLogsForm');
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'delete_multiple_logs';
                input.value = '1';
                form.appendChild(input);
                form.submit();
            };
            
            document.getElementById('deleteMessage').textContent = message;
            document.getElementById('deleteConfirmModal').style.display = 'block';
            
            document.getElementById('confirmDeleteBtn').onclick = function() {
                if(deleteAction) deleteAction();
            };
        }

        function closeDeleteModal() {
            document.getElementById('deleteConfirmModal').style.display = 'none';
            deleteAction = null;
        }

        function toggleSelectAll() {
            const selectAllCheckbox = document.getElementById('selectAll');
            const checkboxes = document.querySelectorAll('.log-checkbox');
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAllCheckbox.checked;
            });
            
            updateDeleteButton();
        }

        function updateDeleteButton() {
            const checkboxes = document.querySelectorAll('.log-checkbox:checked');
            const deleteBtn = document.getElementById('deleteSelectedBtn');
            const countSpan = document.getElementById('selectedCount');
            const selectAllCheckbox = document.getElementById('selectAll');
            
            countSpan.textContent = checkboxes.length;
            
            if(checkboxes.length > 0) {
                deleteBtn.classList.add('active');
            } else {
                deleteBtn.classList.remove('active');
            }

            // Update select all checkbox state
            const allCheckboxes = document.querySelectorAll('.log-checkbox');
            selectAllCheckbox.checked = allCheckboxes.length > 0 && checkboxes.length === allCheckboxes.length;
        }

        window.onclick = function(event) {
            const accountModal = document.getElementById('accountModal');
            const deleteModal = document.getElementById('deleteConfirmModal');
            
            if (event.target == accountModal) {
                closeModal();
            }
            if (event.target == deleteModal) {
                closeDeleteModal();
            }
        }

        // Scroll to logs section if hash is present
        window.addEventListener('load', function() {
            if(window.location.hash === '#logs') {
                document.getElementById('logs').scrollIntoView({behavior: 'smooth'});
            }
        });
    </script>
</body>
</html>