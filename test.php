<?php
// Simple test file to check if PHP is working

echo "<h1>PHP Test File</h1>";
echo "<p>PHP is working!</p>";
echo "<p>PHP Version: " . phpversion() . "</p>";
echo "<p>Current time: " . date('Y-m-d H:i:s') . "</p>";

// Test database connection
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'palatiw_elementary';

$conn = mysqli_connect($host, $username, $password, $database);

if ($conn) {
    echo "<p style='color: green;'>✅ Database connection successful!</p>";
    
    // Check if table exists
    $result = mysqli_query($conn, "SHOW TABLES LIKE 'tblaccounts'");
    if(mysqli_num_rows($result) > 0) {
        echo "<p style='color: green;'>✅ Table 'tblaccounts' exists!</p>";
        
        // Count records
        $count = mysqli_query($conn, "SELECT COUNT(*) as total FROM tblaccounts");
        $row = mysqli_fetch_assoc($count);
        echo "<p style='color: green;'>✅ Total accounts: " . $row['total'] . "</p>";
    } else {
        echo "<p style='color: red;'>❌ Table 'tblaccounts' does NOT exist!</p>";
    }
    
    mysqli_close($conn);
} else {
    echo "<p style='color: red;'>❌ Database connection failed: " . mysqli_connect_error() . "</p>";
}

echo "<hr>";
echo "<h2>Next Steps:</h2>";
echo "<ol>";
echo "<li>If you see this page, PHP is working</li>";
echo "<li>If database connection failed, check your database name and credentials</li>";
echo "<li>If table doesn't exist, run the SQL code in phpMyAdmin</li>";
echo "<li>After all checks pass, try <a href='index.php'>index.php</a></li>";
echo "</ol>";
?>