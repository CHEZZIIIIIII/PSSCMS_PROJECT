<?php
// SAMPLE CONFIG FOR INSTALLATION
// Rename this file to config.php and enter your own credentials.

$host = 'localhost';
$username = 'root';
$password = '';
$database = 'palatiw_elementary';

$conn = mysqli_connect($host, $username, $password, $database);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

mysqli_set_charset($conn, "utf8");
?>